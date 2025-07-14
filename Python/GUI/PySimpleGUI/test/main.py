import PySimpleGUIQt as sg

# import PySimpleGUI as sg

sg.theme('SystemDefault')
layout = [
    [sg.Text('Window location')]
]

win_location = (0, 0)

window = sg.Window('Sample', layout=layout, location=win_location)

while True:
    event, values = window.read()

    if event == sg.WIN_CLOSED:
        break

window.close()

# sg.main()

# sg.Window(title="Hello World", layout=[[]], margins=(100, 50)).read()
