mutable struct Aperture
    subApertures::Vector{SubAperture}
    d::Float64
    ds::Float64
    fs::Float64
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

Aperture() = Aperture([], 0., 0., 0., [], [], Matrix{Complex}([;;]))

function plot(a::Aperture)
    p1 = heatmap(a.x*1e6, a.y*1e6, abs.(a.field).^2, aspect_ratio=:equal)
    title!(p1, "Aperture intensity")
    xaxis!(p1, "x (micron)")
    yaxis!(p1, "y (micron)")

    p2 = heatmap(a.x*1e6, a.y*1e6, angle.(a.field), aspect_ratio=:equal, colorbar_ticks=([0:π/2:2*π]))
    title!(p2, "Aperture phase")
    xaxis!(p2, "x (micron)")
    yaxis!(p2, "y (micron)")
    return [p1, p2]
end

function propagate(a::Aperture, N::Int, x::Vector{Real}, y::Vector{Real})::Matrix{ComplexF64}
    screen = zeros(ComplexF64,N,N)
    for suba in a.subApertures
        # screen .+= fftshift(fft(fftshift(suba.field)))
        phase = exp.(-1im*2pi/N .*(suba.center[1].*x .+ suba.center[2].*y'))
        screen .+= fftshift(fft(fftshift(suba.field.*phase)))
    end
    return screen
end