# Get Lyft wait times
lyftTimes = () ->
	API_key = '_7yKgS-vd7Pr'
	proxy = 'https://paulmakesthe.net/ba-simple-proxy.php'
	lyftURL = 'http://truetime.portauthority.org/bustime/api/v1/getpredictions' + '?key=' + API_key
	xhr = new XMLHttpRequest()

	xhr.open('GET', proxy + '?url=' + encodeURIComponent(lyftURL), true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			result = JSON.parse(xhr.responseText)
			console.log(result)
	xhr.send(null)

lyftTimes()
