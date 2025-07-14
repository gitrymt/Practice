import matplotlib.pyplot as plt
import numpy as np
import PySimpleGUIQt as sg


def draw_plot(fig=None, ax=None):
    if (fig is not None) or (ax is not None):
        x = np.linspace(0, np.pi)
        y = np.sin(x**2) + np.random.rand(x.size)

        ax.cla()
        ax.plot(x, y)

        plt.draw()
        ax.set_aspect(1)
    else:
        x = np.linspace(0, np.pi)
        y = np.sin(x)
        fig, ax = plt.subplots(1, 1, figsize=(5, 3), dpi=100)
        print(fig.get_size_inches())
        fig.set_size_inches(5, 2, forward=False)

        ax.plot(x, y)
        ax.set_aspect(1)
        fig.show()
        print(fig.get_size_inches())
    return fig, ax


if __name__ == "__main__":
    plot_flag = False
    fig = None
    ax = None
    layout = [[sg.Button('Plot'), sg.Button('Close figure'),
               sg.Cancel(), sg.Button('Exit')]]

    window = sg.Window('Have some Matplotlib....', layout, location=(0, 0))

    while True:
        event, values = window.read()
        if event in (sg.WIN_CLOSED, 'Cancel'):
            break
        elif event == 'Plot':
            if plot_flag:
                fig, ax = draw_plot(fig, ax)
            else:
                fig, ax = draw_plot()
                plot_flag = True
        elif event == 'Close figure':
            plt.close()
            plot_flag = False
        elif event == 'Exit':
            # sg.popup('Yes, your application is still running')
            plt.close()
            break

    window.close()
