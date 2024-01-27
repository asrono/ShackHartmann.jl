using FFTW

struct System
    p_initial::Pupil
    p_final::Pupil
end

System() = System(Pupil(), Pupil())

function example_system(r = .1, n = 512)
    p_initial = example_pupil(r, n)
    p_final = initial_to_final_pupil(p_initial)
    exampleSystem = System(p_initial, p_final)
    return exampleSystem
end

function initial_to_final_pupil(p_initial)::Pupil
    dx = (maximum(p_initial.x) - minimum(p_initial.x))/(length(p_initial.x)-1)
    dy = (maximum(p_initial.y) - minimum(p_initial.y))/(length(p_initial.y)-1)
    u = LinRange(-1/(2*dx), 1/(2*dx) - 1/(length(p_initial.x)*dx), length(p_initial.x))
    v = LinRange(-1/(2*dy), 1/(2*dy) - 1/(length(p_initial.y)*dy), length(p_initial.y))
    field = ifftshift(fft(fftshift(p_initial.field)))
    p_final = Pupil(u, v, field)
    return p_final
end