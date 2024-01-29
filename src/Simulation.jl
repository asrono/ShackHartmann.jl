mutable struct Simulation
    Sensor::Sensor
    lambda::Float64
    N::Int
    wavefrontOriginal
    wavefrontReconstructed
end

Simulation() = Simulation(Sensor(), 0., 0, missing, missing)

function example_simulation()::Simulation
    s = Simulation(
        Sensor(),
        100e-8,
        512,
        missing,
        missing
    )
    return s
end