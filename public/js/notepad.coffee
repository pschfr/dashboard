note = document.getElementById('notepad')
logging = false

if logging
    console.log('notepad localStorage item is: ' + localStorage.getItem('dash-notepad'))

# On load, retrive notepad from localStorage
note.value = localStorage.getItem('dash-notepad')

# On input, do this...
note.oninput = (e) ->
    # Store in localStorage
    localStorage.setItem('dash-notepad', e.target.value)

    if logging
        console.log(e.target.value + ' saved to localStorage')
