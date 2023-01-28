using ShackHartmann
using Test

@testset "Test zernike generation" begin
    @test ShackHartmann._R(1,1,2) == 0
end