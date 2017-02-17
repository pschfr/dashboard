hideShowPanels = () ->
	# Get all panels
	panels = document.getElementsByClassName('panel')

	# Loop through em
	for panel, index in panels
		# Add index as data attribute for easy targeting
		panel.dataset.index = index
		# On panel click...
		panel.addEventListener('click', (event) ->
			# If clicked on header or title...
			if event.target.classList.contains('panel-title') or event.target.classList.contains('panel-heading')
				# Find the root panel element, get index
				if event.target.classList.contains('panel-title')
					parentID = event.target.parentElement.parentElement.dataset.index
				else
					parentID = event.target.parentElement.dataset.index

				# Toggle closed state
				panels[parentID].classList.toggle('closed')
		)

hideShowPanels()
