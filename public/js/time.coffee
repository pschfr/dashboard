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
	dateString = dayNames[now.getDay()] + ' ' + monthNames[(now.getMonth())] + ' ' + now.getDate() + ', ' + now.getFullYear()
	document.getElementById('time').innerHTML = timeString
	document.getElementById('date').innerHTML = dateString
	t = setTimeout(currentTime, 500) # Every 1/2 second

currentTime()
