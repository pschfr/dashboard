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

fetchBuses()
