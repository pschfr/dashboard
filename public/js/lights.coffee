# Initialize variables
ip_address = '10.0.0.215'
username = 'WsBtM9ZCwAmafRt32GanUOb5WKU9K1gpZQUJRwSE'
api_url = 'http://' + ip_address + '/api/' + username
switches = document.getElementsByClassName('light-switch')

# Check light state, appending class to buttons if necessary
checkState = (light) ->
	xhr = new XMLHttpRequest()
	if light.id.toString() == 'seahorse' || light.id.toString() == 'bedroom'
		if light.id.toString() == 'seahorse'
			xhr.open('GET', api_url + '/lights/1', true)
		else if light.id.toString() == 'bedroom'
			xhr.open('GET', api_url + '/lights/2', true)
		xhr.onreadystatechange = () ->
			if xhr.readyState == 4 && xhr.status == 200
				if JSON.parse(xhr.responseText).state.on
					light.classList.add('on')
					light.children[0].classList.remove('fa-toggle-off')
					light.children[0].classList.add('fa-toggle-on')
		xhr.send(null)

# Loop through buttons, checking state then adding click events
for light in switches
	checkState(light)
	light.addEventListener('click', (event) ->
		if (!this.classList.toString().includes('on'))
			this.classList.add('on')
			this.children[0].classList.remove('fa-toggle-off')
			this.children[0].classList.add('fa-toggle-on')
			turnOn(this.id.toString(), 254)
		else
			this.classList.remove('on')
			this.children[0].classList.remove('fa-toggle-on')
			this.children[0].classList.add('fa-toggle-off')
			turnOff(this.id.toString())
	)

# Turns light on!
turnOn = (light, brightness) ->
	xhr = new XMLHttpRequest()
	if (light == 'seahorse')
		xhr.open('PUT', api_url + '/lights/1/state', true)
		xhr.send(JSON.stringify({on: true, bri: brightness}))
	else if (light == 'bedroom')
		xhr.open('PUT', api_url + '/lights/2/state', true)
		xhr.send(JSON.stringify({on: true, bri: brightness}))
	else if (light == 'bothlights')
		xhr.open('PUT', api_url + '/groups/0/action', true)
		xhr.send(JSON.stringify({on: true, bri: brightness}))

# Turns light off...
turnOff = (light) ->
	xhr = new XMLHttpRequest()
	if (light == 'seahorse')
		xhr.open('PUT', api_url + '/lights/1/state', true)
		xhr.send(JSON.stringify({on: false}))
	else if (light == 'bedroom')
		xhr.open('PUT', api_url + '/lights/2/state', true)
		xhr.send(JSON.stringify({on: false}))
	else if (light == 'bothlights')
		xhr.open('PUT', api_url + '/groups/0/action', true)
		xhr.send(JSON.stringify({on: false}))
