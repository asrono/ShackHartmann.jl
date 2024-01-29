module ShackHartmann

export W

export Pupil, plot_pupil, example_pupil

export System, example_system

export Simulation, example_simulation

include("zernikes.jl")
include("Pupil.jl")
include("System.jl")

include("SubAperture.jl")
include("Aperture.jl")
include("Screen.jl")
include("Sensor.jl")
include("Simulation.jl")

end
