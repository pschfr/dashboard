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
			element.innerHTML = ''
			for day in JSON.parse(xhr.responseText).list
				temp = Math.round(day.main.temp)
				iconClass = iconIDtoClass(day.weather[0].icon)
				date = day.dt_txt
				if (date.includes('12:00:00'))
					element.innerHTML += '<div class="day"><small class="text-muted">' + new Date(date).toString().split(' ').slice(0, 1) + '<br>' + new Date(date).toString().split(' ').slice(1, 3).join(' ') + '</small><br/><i class="climacon ' + iconClass + '" aria-hidden="true"></i><br/>' + temp + '&deg</div>'
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



geolocWeather()
