struct Pupil
    x::Vector{Real}
    y::Vector{Real}
    wavefront::Matrix{Complex}
end

Pupil() = Pupil(Vector{Real}(), Vector{Real}(), Matrix{Complex}([;;]))