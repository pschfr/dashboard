# Gets time and date, formats it properly
currentTime = () ->
	monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
	dayNames   = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
	now = new Date()
	if (now.getHours() >= 12)
		ampm = 'PM'
	else
		ampm = 'AM'
	timeString = (now.getHours() % 12) + ':' + now.getMinutes().toString().replace(/\b(\d)\b/g, '0$1') + ':' + now.getSeconds().toString().replace(/\b(\d)\b/g, '0$1') + ' ' + ampm
	dateString = dayNames[now.getDay()] + ' ' + monthNames[(now.getMonth() + 1)] + ' ' + now.getDate() + ', ' + now.getFullYear()
	document.getElementById('time').innerHTML = timeString
	document.getElementById('date').innerHTML = dateString
	t = setTimeout(currentTime, 500) # Every 1/2 second



# Attempt to geolocate user
geolocWeather = () ->
	if ('geolocation' in navigator) # I don't know if this works
		navigator.geolocation.getCurrentPosition((position) ->
			fetchWeather(position.coords.latitude, position.coords.longitude)
			fetchForecast(position.coords.latitude, position.coords.longitude)
		)
	else
		fetchWeather('40.4406', '-79.9959')
		fetchForecast('40.4406', '-79.9959')
	t = setTimeout(geolocWeather, 900000) # Every 15 min



# Fetch weather from OpenWeatherMap
fetchWeather = (lat, lon) ->
	API_key = 'cb2555990c5309b5ffb90ba6fdea4c62'
	owm_URL = 'http://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' + lon + '&APPID=' + API_key + '&units=imperial'
	xhr = new XMLHttpRequest()

	xhr.open('GET', owm_URL, true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			weather = JSON.parse(xhr.responseText)
			location = weather.name
			condition = weather.weather[0].description
			temperature = Math.round(weather.main.temp)
			windSpeed = Math.round(weather.wind.speed)
			windDeg = weather.wind.deg
			directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
			windDir = directions[(Math.floor((windDeg / 22.5) + 0.5) % 16)]
			humidity = weather.main.humidity
			iconClass = iconIDtoClass(weather.weather[0].icon)

			document.getElementById('condition').innerHTML = '<i class="climacon ' + iconClass + '" aria-hidden="true"></i>'
			document.getElementById('current').innerHTML = '<h3>' + temperature + '&deg;<br/> ' + condition + '</h3><p class="text-muted">' + windSpeed + 'mph ' + windDir + '<br/>' + humidity + '% humidity</p>'
			document.getElementById('location').innerHTML = location
			# console.log(weather)
	xhr.send(null)

# Fetch forecast from OpenWeatherMap
fetchForecast = (lat, lon) ->
	API_key = 'cb2555990c5309b5ffb90ba6fdea4c62'
	owm_URL = 'http://api.openweathermap.org/data/2.5/forecast?lat=' + lat + '&lon=' + lon + '&APPID=' + API_key + '&units=imperial'
	element = document.getElementById('forecast')
	xhr = new XMLHttpRequest()

	xhr.open('GET', owm_URL, true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			for day in JSON.parse(xhr.responseText).list
				temp = Math.round(day.main.temp)
				iconClass = iconIDtoClass(day.weather[0].icon)
				date = day.dt_txt
				if (date.includes('12:00:00'))
					element.innerHTML += '<div class="day"><small class="text-muted text-uppercase">' + new Date(date).toString().split(' ').slice(1, 3).join(' ') + '</small><br/><i class="climacon ' + iconClass + '" aria-hidden="true"></i><br/>' + temp + '&deg</div>'
					# console.log(day, temp, iconClass, new Date(date))
	xhr.send(null)


# Takes the icon ID from OpenWeatherMap and transforms it into a class I can use
iconIDtoClass = (iconID) ->
	if (iconID == '01d')
		iconClass = 'sun'
	else if (iconID == '01n')
		iconClass = 'moon'
	else if (iconID == '02d' || iconID == '04d')
		iconClass = 'cloud sun'
	else if (iconID == '02n' || iconID == '04n')
		iconClass = 'cloud moon'
	else if (iconID == '03d' || iconID == '03n')
		iconClass = 'cloud'
	else if (iconID == '09d' || iconID == '10d')
		iconClass = 'rain'
	else if (iconID == '09n' || iconID == '10n')
		iconClass = 'rain moon'
	else if (iconID == '11d')
		iconClass = 'lightning'
	else if (iconID == '11n')
		iconClass = 'lightning moon'
	else if (iconID == '13d' || iconID == '13n')
		iconClass = 'snow'
	else if (iconID == '50d' || iconID == '50n')
		iconClass = 'fog'
	else
		iconClass = 'cloud'



# Fetch bus times from PortAuthority
fetchBuses = () ->
	API_key = '4EycNF36ZzhQnyHQBsrgVCx8C'
	portURL = 'http://truetime.portauthority.org/bustime/api/v1/gettime'
	xhr = new XMLHttpRequest()

	xhr.open('GET', portURL, true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			times = JSON.parse(xhr.responseText)
			# console.log(times)
	xhr.send(null)



# Gets surge pricing, wait times, and est. cost from the Uber API
uberInfo = () ->
	API_key = '1TTcGJNB_ltPhjaH0Lp1oHjypAYSFFxrwmhncRDi'
	lat = '40.4406'
	lng = '-79.9959'
	uberURL = 'https://api.uber.com/v1.2/estimates/time?start_latitude=' + lat + '&start_longitude=' + lng
	xhr = new XMLHttpRequest()

	xhr.open('GET', uberURL, true)
	# xhr.setRequestHeader('Access-Control-Allow-Origin', '*')
	xhr.setRequestHeader('Authorization', 'Token ' + API_key)
	# xhr.send()

	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			times = JSON.parse(xhr.responseText)
			# console.log(times)
	xhr.send(null)




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
				document.getElementById('news').innerHTML += '<li class="list-group-item"><a href="' + article.url + '" title="' + article.abstract + '">' + article.title + ' <small>' + article.byline.replace('By ', ' &mdash; ') + '</small></a></li>'
				# console.log(article)
	xhr.send(null)



# Launch everything!
currentTime()
geolocWeather()
# fetchBuses()
# uberInfo()
# unreadEmails()
getHeadlines()
