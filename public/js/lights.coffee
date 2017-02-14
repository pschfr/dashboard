ip_address = '10.0.0.215'
username = 'WsBtM9ZCwAmafRt32GanUOb5WKU9K1gpZQUJRwSE'
api_url = 'http://' + ip_address + '/api/' + username
switches = document.getElementsByClassName('light-switch')
xhr = new XMLHttpRequest()

for light in switches
	light.addEventListener('click', (event) ->
		if (!this.classList.toString().includes('on'))
			this.classList.add('on')
			this.children[0].classList.remove('fa-toggle-off')
			this.children[0].classList.add('fa-toggle-on')
			turnOn(this.id.toString(), '254')
		else
			this.classList.remove('on')
			this.children[0].classList.remove('fa-toggle-on')
			this.children[0].classList.add('fa-toggle-off')
			turnOff(this.id.toString())
	)



turnOn = (light, brightness) ->
	if (light == 'bedroom')
		xhr.open('PUT', api_url + '/lights/1/state', true)
		xhr.send(JSON.stringify({on: true, bri: brightness}))
	else if (light == 'landing')
		xhr.open('PUT', api_url + '/lights/2/state', true)
		xhr.send(JSON.stringify({on: true, bri: brightness}))
	else if (light == 'bothlights')
		xhr.open('PUT', api_url + '/groups/0/action', true)
		xhr.send(JSON.stringify({on: true, bri: brightness}))



turnOff = (light) ->
	if (light == 'bedroom')
		xhr.open('PUT', api_url + '/lights/1/state', true)
		xhr.send(JSON.stringify({on: false}))
	else if (light == 'landing')
		xhr.open('PUT', api_url + '/lights/2/state', true)
		xhr.send(JSON.stringify({on: false}))
	else if (light == 'bothlights')
		xhr.open('PUT', api_url + '/groups/0/action', true)
		xhr.send(JSON.stringify({on: false}))
