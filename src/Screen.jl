mutable struct Screen
    x::Vector{Real}
    y::Vector{Real}
    field::Matrix{ComplexF64}
end

Screen() = Screen([],[], Matrix{Complex}([;;]))