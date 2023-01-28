using ShackHartmann
using Test

@testset "Zernike radial function" begin
    @test ShackHartmann.R(0.5; n=1, m=1) isa Float64
    @test_throws AssertionError("n has to be non-negative!") ShackHartmann.R(0.0; n=-1, m=1)
    @test_throws AssertionError("n has to be at least abs(m)") ShackHartmann.R(0.0; n=3, m=4)
    @test_throws AssertionError("In your input, n - m has to be even!") ShackHartmann.R(0; n=2, m=1) 
    @test_throws AssertionError("Ensure r is restricted to the unit circle (0<=r<=1)") ShackHartmann.R(-0.1; n=3, m=1)
    @test_throws AssertionError("Ensure r is restricted to the unit circle (0<=r<=1)") ShackHartmann.R(1.1; n=3, m=3)

    @test ShackHartmann.R(1; n=0, m=0) == 1.0
    @test ShackHartmann.R(1; n=3, m=3) == 1.0
    @test ShackHartmann.R(0; n=2, m=0) == -1.0

    @test ShackHartmann.R.([0., 1.0];  n=0, m=0) == [1.0, 1.0]
end

@testset "Zernike radial function" begin
    @test ShackHartmann.Z(1, 0; n=0, m=0) == 1.0
    @test ShackHartmann.Z(1, 0; n=1, m=-1) == 0.0
    @test ShackHartmann.Z(1, π/2; n=1, m=-1) == 1.0

end