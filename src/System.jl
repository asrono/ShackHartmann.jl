using FFTW

mutable struct System
    p_initial::Pupil
    p_final::Pupil
    d::Real
    f::Real
    lambda::Real
    N::Int
end

System() = System(Pupil(), Pupil(), 1. , 1., 1., 1)

function example_system()
    d = 150e-6 # m
    f = 150e-6 # m
    Nx = 2^9
    lambda = 100e-8 # m

    alphax = 0 # degrees
    alphay = atan(0.5)*180/pi # degrees

    dx = lambda*f/d
    x = (-Nx/2:Nx/2-1).*dx
    y = x
    r = sqrt.(x.^2 .+ y'.^2)
    mask = (r .<= d/2)
    # wavefront = mask.*exp.(1im*2*pi/lambda.*(sin(alphax*pi/180).*x.+sin(alphay*pi/180).*y'));
    theta = atan.(y,x)

    c = [0., 0., 0., 2000/lambda]
    wavefront2 = W.(r,theta', (c,))

    wavefront = mask.*exp.(1im*2*pi/lambda.*wavefront2);
    p_initial = Pupil(x, y, wavefront)

    example_system = System(p_initial, Pupil(), d, f, lambda, Nx)
    propagate!(example_system)
    return example_system
end

function propagate!(s::System)::System
    Nu = s.N
    dx = (maximum(s.p_initial.x) - minimum(s.p_initial.x))/(length(s.p_initial.x)-1)
    du = 1/dx/Nu*s.lambda*s.f
    u = (-Nu/2:Nu/2-1)*du
    v = u
    field = fftshift(fft(fftshift(s.p_initial.field)))
    s.p_final = Pupil(u, v, field)
    return s
end