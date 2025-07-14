import numpy as np
from whitecanvas import new_canvas

canvas = new_canvas("matplotlib:qt")

x = np.linspace(-np.pi, np.pi, 100)

line = canvas.add_line(np.cos(x**2), np.sin(x**3), color="r")
markers = canvas.add_markers(np.cos(x), np.sin(x), color="gray")

canvas.show()
