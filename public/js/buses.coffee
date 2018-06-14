# Fetch bus times from PortAuthority
fetchBuses = () ->
	API_key = '4EycNF36ZzhQnyHQBsrgVCx8C'
	proxy = 'https://paulmakesthe.net/ba-simple-proxy.php'
	# portURL = 'http://truetime.portauthority.org/bustime/api/v1/getstops' + '?key=' + API_key + '&rt=P1&dir=OUTBOUND'
	portURL = 'http://truetime.portauthority.org/bustime/api/v1/getpredictions' + '?key=' + API_key + '&stpid=8162,20501'
	xhr = new XMLHttpRequest()

	xhr.open('GET', proxy + '?url=' + encodeURIComponent(portURL), true)
	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			result = JSON.parse(xhr.responseText)
			times = new DOMParser().parseFromString(result.contents, 'text/xml')
			console.log(times.childNodes[0])
	xhr.send(null)

fetchBuses()
