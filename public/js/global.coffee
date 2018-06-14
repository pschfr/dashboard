hideShowPanels = () ->
	# Get all panels
	panels = document.getElementsByClassName('panel')

	# Loop through em
	for panel, id in panels
		# Add id as data attribute for easy targeting
		panel.dataset.id = id
		# On panel click...
		panel.addEventListener('click', (event) ->
			# If clicked on header or title...
			if event.target.classList.contains('panel-title') or event.target.classList.contains('panel-heading')
				# Find the root panel element, get id
				if event.target.classList.contains('panel-title')
					parentID = event.target.parentElement.parentElement.dataset.id
				else
					parentID = event.target.parentElement.dataset.id

				# Toggle closed state
				panels[parentID].classList.toggle('closed')

				# Adds open/closed state to localStorage
				if panels[parentID].classList.contains('closed')
					localStorage.setItem('panel' + parentID, 'closed')
				else
					localStorage.setItem('panel' + parentID, 'open')
		)

		# Checks for closed panels...
		if localStorage.getItem('panel' + id) == 'closed'
			panel.classList.add('closed')
		else if localStorage.getItem('panel' + id) == 'open'
			panel.classList.remove('closed')

hideShowPanels()

# Initiates Sortable
Sortable.create(document.getElementsByClassName('panels')[0], {
	animation: 150,
	draggable: ".panel",
	handle: ".panel-heading"
	# Add restoration of the sort, see https://github.com/RubaXa/Sortable#store
})
