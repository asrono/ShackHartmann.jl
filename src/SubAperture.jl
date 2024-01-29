mutable struct SubAperture
    center::Tuple{Float64, Float64}
    d::Float64
    f::Float64
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

SubAperture() = SubAperture((0., 0.), 0., 0., [], [], Matrix{Complex}([;;]))
