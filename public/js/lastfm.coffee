# Load scrobbles from Last.fm
lastFMrequest = () ->
	username = 'paul_r_schaefer'
	API_key = '0f680404e39c821cac34008cc4d803db'
	lastFM_URL = 'https://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=' + username + '&api_key=' + API_key + '&limit=1&format=json'
	xhr = new XMLHttpRequest()
	music = document.getElementById('music')
	title = document.getElementById('title')
	image = document.getElementById('image')

	xhr.open('GET', lastFM_URL, true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			track = JSON.parse(xhr.responseText).recenttracks.track[0]
			url = track.url
			artist = track.artist['\#text']
			album = track.album['\#text']
			song = track.name
			imgURL = track.image[3]['\#text']

			if track['\@attr'] and track['\@attr'].nowplaying != ''
				title.innerHTML = 'Now Playing'
			else
				title.innerHTML = 'Last Song'

			image.innerHTML += '<img src="' + imgURL + '" alt="' + album + '" title="' + album + '" class="thumbnail" style="width:100%">'
			music.innerHTML += '<p style="margin:0"><a href="' + url + '" style="color:inherit">' + song + '<br><small class="text-muted">' + artist + ' &mdash; ' + album + '</small></a></p>'
	xhr.send(null)

lastFMrequest()
