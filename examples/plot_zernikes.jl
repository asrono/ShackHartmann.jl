using ShackHartmann
using Plots
plotlyjs()

r = range(0.,1., 100)
theta = π/4

c = [0., 0., 0., 1.]
wavefront = W.(r,theta, (c,))
p1 = plot(r, wavefront, aspect_ratio=:equal)
title!(p1, "Z_2^-2")


r = range(0.,1., 100)
theta = range(0.,2π, 100)

x = r.*sin.(theta')
y = r.*cos.(theta')

c = [0., 0., 0., 0., 0., 0., 1.]
wavefront = W.(r,theta', (c,))
p2 = surface(x, y, wavefront)
title!(p2, "Z_2^-2")
plot(p1, p2, layout = 2, size = (800, 600))
