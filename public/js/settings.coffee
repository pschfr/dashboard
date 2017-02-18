# Global settings will go here
globalSettings = () ->
	# Toggles light/dark mode
	lightDark = document.getElementById('lightDark')
	lightDarkState = document.getElementById('lightDarkState')
	lightDark.addEventListener('click', (event) ->
		if (!this.classList.toString().includes('dark'))
			lightDarkState.innerHTML = 'Dark'
			this.classList.add('dark')
			this.children[0].classList.remove('fa-sun-o')
			this.children[0].classList.add('fa-moon-o')
			document.getElementsByTagName('body')[0].classList.add('dark')
		else
			lightDarkState.innerHTML = 'Light'
			this.classList.remove('dark')
			this.children[0].classList.remove('fa-moon-o')
			this.children[0].classList.add('fa-sun-o')
			document.getElementsByTagName('body')[0].classList.remove('dark')
	)

globalSettings()
