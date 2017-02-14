# Connects to Gmail and fetches unread message count
unreadEmails = () ->
	gmailURL = 'https://mail.google.com/mail/u/0/feed/atom'
	element = document.getElementById('gmail')
	xhr = new XMLHttpRequest()
	
	xhr.open('GET', gmailURL, true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			parser    = new DOMParser()
			xmlDoc    = parser.parseFromString(xhr.responseText, 'application/xml')
			email     = xmlDoc.getElementsByTagName('title')[0].innerHTML.replace('Gmail - Inbox for ', '')
			count     = xmlDoc.getElementsByTagName('fullcount')[0].innerHTML
			entries   = xmlDoc.getElementsByTagName('entry')
			entryList = email + ":\n"

			if (entries.length == 0)
				element.innerHTML = "<p><a href='" + gmailURL.replace('/feed/atom', '') + "' id='emaillink'>Inbox zero. Enjoy your day.</a></p>\n"
			else
				for entry in entries
					entryTitle = entry.getElementsByTagName('title')[0].innerHTML.replace(/"/g, '&quot;').replace(/'/g, '&#39;')
					authorName = entry.getElementsByTagName('author')[0].getElementsByTagName('name')[0].innerHTML.replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;')
					entryList += authorName + ' &mdash; ' + entryTitle + "\n"
				element.innerHTML = "<p><a href='" + gmailURL.replace('/feed/atom', '') + "' id='emaillink' title='" + entryList + "'>" + count + " unread emails</a></p>\n"
	xhr.send(null)

unreadEmails()
