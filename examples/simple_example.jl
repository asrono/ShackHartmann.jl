using ShackHartmann
using PlotlyJS

r = range(0.,1., 100)
theta = π/4

c = [0., 0., 0., 1.]
wavefront = W.(r,theta, (c,))
plot(r, wavefront, Layout(title="Z_2^-2"))

r = range(0.,1., 100)
theta = range(0.,2π, 100)

x = r.*sin.(theta')
y = r.*cos.(theta')

c = [0., 0., 0., 1.]
wavefront = W.(r,theta', (c,))
s = surface(z = wavefront, x=x, y=y)
l = Layout(title="Z_2^-2")
plot(s,l)
