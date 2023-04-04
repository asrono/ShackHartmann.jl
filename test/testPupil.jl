using ShackHartmann
using Test

@testset "Pupil" begin
    P1 = Pupil()
    @test P1.x isa Vector{Real}
    @test P1.y isa Vector{Real}
    @test P1.wavefront isa Matrix{Complex}

    x = Vector(LinRange(-1,1,64))
    y = Vector(LinRange(-1,1,64))
    W = Matrix{Complex}(x.*y')
    P2 = Pupil(x,y,W)

    @test size(P2.wavefront) == (64,64)
    @test P2.wavefront[1] == 1.0 + 0.0im
end
