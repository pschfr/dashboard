# Gets surge pricing, wait times, and est. cost from the Uber API
uberInfo = () ->
	API_key = '1TTcGJNB_ltPhjaH0Lp1oHjypAYSFFxrwmhncRDi'
	lat = '40.4406'
	lng = '-79.9959'
	proxy = 'https://paulmakesthe.net/ba-simple-proxy.php'
	uberURL = 'https://api.uber.com/v1.2/estimates/time?start_latitude=' + lat + '&start_longitude=' + lng
	xhr = new XMLHttpRequest()

	xhr.open('GET', proxy + '?url=' + uberURL, true)
	# xhr.setRequestHeader('Access-Control-Allow-Origin', '*')
	xhr.setRequestHeader('Authorization', 'Token ' + API_key)
	# xhr.send()

	xhr.onreadystatechange = () ->
		if (xhr.readyState == 4 && xhr.status == 200)
			times = JSON.parse(xhr.responseText)
			# console.log(times)
	xhr.send(null)

uberInfo()
