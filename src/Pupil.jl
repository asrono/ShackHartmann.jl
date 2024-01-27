using Plots
struct Pupil
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

Pupil() = Pupil(Vector{Real}(), Vector{Real}(), Matrix{Complex}([;;]))

function plot_pupil(P::Pupil)
    p1 = heatmap(P.x, P.y, log.(abs.(P.field).^2), aspect_ratio=:equal)
    title!(p1, "Intensity")
    xaxis!("x (m)")
    yaxis!("y (m)")

    p2 = heatmap(P.x, P.y, angle.(P.field), aspect_ratio=:equal, colorbar_ticks=([0:π/2:2*π]))
    title!(p2, "Phase")
    xaxis!("x (m)")
    yaxis!("y (m)")

    p = plot(p1, p2, size=(1200,1000))
    return p
end

function example_pupil(r::Real = 0.1, n::Int = 16)::Pupil
    x = range(-r, r, n)
    y = range(-r, r, n)
    rad = sqrt.(x.^2 .+ y'.^2)
    theta = atan.(y, x)
    c = [0., 0., 0., 1.]
    wavefront = W.(rad, theta', (c,))
    mask = (rad .<= 0.03)
    P = Pupil(x, y, mask.*exp.(2*pi*1im .*wavefront))
    return P
end