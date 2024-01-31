mutable struct Screen
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

Screen() = Screen([],[], Matrix{Complex}([;;]))

function plot(s::Screen)
    p = heatmap(s.x*1e6, s.y*1e6, log.(abs.(s.field).^2), aspect_ratio=:equal)
    title!(p, "Screen intensity")
    xaxis!(p, "x (micron)")
    yaxis!(p, "y (micron)")
    return p
end