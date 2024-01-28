using Plots
struct Pupil
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

Pupil() = Pupil(Vector{Real}(), Vector{Real}(), Matrix{Complex}([;;]))

function plot_pupil(P::Pupil)
    p1 = heatmap(P.x*1e6, P.y*1e6, (abs.(P.field).^2), aspect_ratio=:equal)
    title!(p1, "Intensity")
    xaxis!("x (micron)")
    yaxis!("y (micron)")

    p2 = heatmap(P.x*1e6, P.y*1e6, angle.(P.field), aspect_ratio=:equal, colorbar_ticks=([0:π/2:2*π]))
    title!(p2, "Phase")
    xaxis!("x (micron)")
    yaxis!("y (micron)")

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


function initial_to_final_pupil(p_initial)::Pupil
    dx = (maximum(p_initial.x) - minimum(p_initial.x))/(length(p_initial.x)-1)
    dy = (maximum(p_initial.y) - minimum(p_initial.y))/(length(p_initial.y)-1)
    u = LinRange(-1/(2*dx), 1/(2*dx) - 1/(length(p_initial.x)*dx), length(p_initial.x))
    v = LinRange(-1/(2*dy), 1/(2*dy) - 1/(length(p_initial.y)*dy), length(p_initial.y))
    field = fftshift(fft(fftshift(p_initial.field)))
    p_final = Pupil(u, v, field)
    return p_final
end