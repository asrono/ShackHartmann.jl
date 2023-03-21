using ShackHartmann
using PlotlyJS

r = range(0.,1., 100)
theta = π/4

c = [0., 0., 0., 1.]
wavefront = W.(r,theta, (c,))
plot(r, wavefront, Layout(title="Z_2^-2"))
