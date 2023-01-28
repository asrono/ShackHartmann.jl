using ShackHartmann
using Test

@testset "Test zernike generation" begin
    @test ShackHartmann.R(1,1,2) == 0
end