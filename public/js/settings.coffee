# Global variables will go here
lightDark = document.getElementById('lightDark')
lightDarkState = document.getElementById('lightDarkState')
tempUnit = document.getElementById('tempUnit')
tempUnitState = document.getElementById('tempUnitState')

# Looks to see if user set it to dark in localStorage, binds click events
lightDarkMode = () ->
	if localStorage.getItem('color-mode') == 'dark'
		makeDark()
	else
		makeLight()
	lightDark.addEventListener('click', (event) ->
		if (!this.classList.toString().includes('dark'))
			makeDark()
			localStorage.setItem('color-mode', 'dark')
		else
			makeLight()
			localStorage.setItem('color-mode', 'light')
	)

# Sets dark mode
makeDark = () ->
	lightDarkState.innerHTML = 'Dark'
	lightDark.classList.add('dark')
	lightDark.children[0].classList.remove('fa-sun-o')
	lightDark.children[0].classList.add('fa-moon-o')
	document.getElementsByTagName('body')[0].classList.add('dark')

# Likewise, light mode
makeLight = () ->
	lightDarkState.innerHTML = 'Light'
	lightDark.classList.remove('dark')
	lightDark.children[0].classList.remove('fa-moon-o')
	lightDark.children[0].classList.add('fa-sun-o')
	document.getElementsByTagName('body')[0].classList.remove('dark')






# Looks for set weather unit
setTempUnit = () ->
	if localStorage.getItem('temp-unit') == 'metric'
		setMetric()
	else
		setImperial()
	tempUnit.addEventListener('click', (event) ->
		if (!this.classList.toString().includes('metric'))
			setMetric()
			localStorage.setItem('temp-unit', 'metric')
		else
			setImperial()
			localStorage.setItem('temp-unit', 'imperial')

		location.reload()
	)

# Sets unit to metric
setMetric = () ->
	tempUnitState.innerHTML = 'Celcius'
	tempUnit.classList.add('metric')
	tempUnit.classList.remove('imperial')


# Likewise, but for us Muricans
setImperial = () ->
	tempUnitState.innerHTML = 'Fahrenheit'
	tempUnit.classList.add('imperial')
	tempUnit.classList.remove('metric')






# Initiate all global settings
lightDarkMode()
setTempUnit()
