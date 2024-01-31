using Plots

mutable struct Simulation
    sensor::Sensor
    lambda::Float64
    N::Int
    wavefrontOriginal
    wavefrontReconstructed
end

Simulation() = Simulation(Sensor(), 0., 0, missing, missing)

function example_simulation()::Simulation
    s = Simulation(
        example_sensor(),
        500e-9,
        1024,
        missing,
        missing
    )
    return s
end

function initialize!(s::Simulation)::Simulation
    # coordinate system
    dx = s.lambda*s.sensor.aperture.fs/s.sensor.aperture.d
    s.sensor.aperture.x = (-s.N/2:s.N/2-1).*dx
    s.sensor.aperture.y = (-s.N/2:s.N/2-1).*dx

    # main aperture
    r = sqrt.(s.sensor.aperture.x.^2 .+ s.sensor.aperture.y'.^2)
    mask = (r .<= s.sensor.aperture.d/2)

    # field of main aperture
    alphax = 0 # degrees
    alphay = 10 # degrees
    s.sensor.aperture.field = mask.*exp.(1im*2*pi/s.lambda.*(
            sin(alphax*pi/180).*s.sensor.aperture.x .+ 
            sin(alphay*pi/180).*s.sensor.aperture.y'
            )
        )
    
    # subapertures
    for suba in s.sensor.aperture.subApertures
        rSuba = sqrt.((s.sensor.aperture.x .- suba.center[1]).^2 .+ (s.sensor.aperture.y .- suba.center[2])'.^2)
        maskSuba = (rSuba .<= s.sensor.aperture.ds/2)
        suba.field = maskSuba.*s.sensor.aperture.field
        s.sensor.aperture.field .-= suba.field
    end

    # screen
    du = 1/dx/s.N*s.lambda*s.sensor.aperture.fs
    s.sensor.screen.x = (-s.N/2:s.N/2-1).*du
    s.sensor.screen.y = (-s.N/2:s.N/2-1).*du
    s.sensor.screen.field = ones(s.N, s.N)
    return s
end

function propagate!(s::Simulation)::Simulation
    s.sensor.screen.field = propagate(s.sensor.aperture, s.N, s.sensor.screen.x, s.sensor.screen.y)
    return s
end

function plot(s::Simulation)
    # plotlyjs()
    ps = plot(s.sensor.aperture)
    push!(ps, plot(s.sensor.screen))

    p = Plots.plot(ps..., size=(1200,1000))
    return p
end