using ShackHartmann

s = example_simulation()
initialize!(s)
propagate!(s)
plot(s)