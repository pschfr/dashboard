# Google Cast Web API URL
cast_api_url = 'http://10.0.0.27:3000/'
nowplaying = ''

# Fetch a list of devices connected, return info
fetchDevices = () ->
	# console.log 'being fetched'
	xhr = new XMLHttpRequest()
	xhr.open('GET', cast_api_url + 'device/connected', true)
	xhr.onreadystatechange = () ->
		if xhr.readyState == 4 && xhr.status == 200
			if JSON.parse(xhr.responseText).length
				for device in JSON.parse(xhr.responseText)
					# console.log device
					if device.status.title
						nowplaying += device.status.title + ' — ' + device.status.subtitle
					else
						nowplaying += 'API is connected, nothing is casting.'
					if device.status.image
						document.getElementById('cast-image').style.display = 'block'
						document.getElementById('cast-image').innerHTML = image.innerHTML = '<img src="' + device.status.image + '" alt="' + device.status.title + '" title="' + device.status.title + '" class="thumbnail" style="width:100%">'
					nowplaying += '<br/><br/><small>Connected to: ' + device.status.application + ' on ' + device.name + '</small>'
					if device.status.title
						document.getElementById('cast-play-pause').setAttribute('cast-id', device.id)
						document.getElementById('cast-play-pause').setAttribute('cast-state', device.status.status)
						document.getElementById('cast-play-pause').style.display = 'inline-block'
						document.getElementById('cast-play-pause').getElementsByClassName('fa-play')[0].style.display = 'none'
					else
						document.getElementById('cast-play-pause').style.display = 'none'
			else
				nowplaying += 'API is connected, nothing is casting.'
				console.log 'here', nowplaying
		else
			nowplaying += 'API connection failed.'
		document.getElementById('cast-playing').innerHTML = nowplaying
	xhr.send(null)
fetchDevices()


playPauseContent = (id, state) ->
	console.log id, state, 'playPause'
	if state == 'PLAYING'
		state = 'pause'
	else if state == 'PAUSED'
		state = 'play'
	xhr = new XMLHttpRequest()
	xhr.open('POST', cast_api_url + 'device/' + id + '/' + state, true)
	xhr.onreadystatechange = () ->
		if xhr.readyState == 4 && xhr.status == 200
			console.log 'playPaused'
			if state == 'pause'
				# Show play icon, change state to paused
				document.getElementById('cast-play-pause').setAttribute('cast-state', 'PAUSED')
				document.getElementById('cast-play-pause').getElementsByClassName('fa-play')[0].style.display = 'inline-block'
				document.getElementById('cast-play-pause').getElementsByClassName('fa-pause')[0].style.display = 'none'
				document.getElementById('cast-play-pause').setAttribute('title', 'Play')
			else
				# Show pause icon, change state to playing
				document.getElementById('cast-play-pause').setAttribute('cast-state', 'PLAYING')
				document.getElementById('cast-play-pause').getElementsByClassName('fa-play')[0].style.display = 'none'
				document.getElementById('cast-play-pause').getElementsByClassName('fa-pause')[0].style.display = 'inline-block'
				document.getElementById('cast-play-pause').setAttribute('title', 'Pause')
	xhr.send(null)
document.getElementById('cast-play-pause').addEventListener('click', () -> playPauseContent(document.getElementById('cast-play-pause').getAttribute('cast-id'), document.getElementById('cast-play-pause').getAttribute('cast-state')))

