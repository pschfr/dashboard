# Today's headlines from the New York Times
getHeadlines = () ->
	API_key = '104b5f376c34489f8575c1d8b99ea2d3'
	nyt_URL = 'https://api.nytimes.com/svc/topstories/v2/home.json?api-key=' + API_key
	xhr = new XMLHttpRequest()

	xhr.open('GET', nyt_URL, true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			times = JSON.parse(xhr.responseText)
			# console.log(times)
			for article in times.results
				if !article.title.includes('Briefing') and !article.title.includes('briefing')
					document.getElementById('news').innerHTML += '<li class="list-group-item"><a href="' + article.url + '" title="' + article.abstract + '">' + article.title + ' <small>' + article.byline.replace('By ', ' &mdash; ') + '</small></a></li>'
					# console.log(article)
	xhr.send(null)

getHeadlines()
