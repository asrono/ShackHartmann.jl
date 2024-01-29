mutable struct Aperture
    subApertures::Vector{SubAperture}
    d::Float64
    f::Float64
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

Aperture() = Aperture([], 0., 0., [], [], Matrix{Complex}([;;]))
