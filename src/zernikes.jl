## W = sum_j C_j*Z_j(r,x,y) = sum_(n,m) C_n^m*Z_n^m(r,theta)
# x = r*sin(theta)
# y = r*cos(theta)

# Z_n^m(r,theta) = R_n^m(r)*cos(m*theta) if m >= 0
# Z_n^-m(r,theta) = R_n^m(r)*sin(m*theta) if m < 0
# NOTE: theta is measured clockwise from the y-axis. This is consistent with aberration theory, but different from conventional mathematical definition

function R(r::Real; n::Int,m::Int)::Float64
    @assert n>=0 "n has to be non-negative!"
    @assert abs(m)<=n "n has to be at least abs(m)"
    @assert (n - m) % 2 == 0 "In your input, n - m has to be even!"
    @assert 0<=r<=1 "Ensure r is restricted to the unit circle (0<=r<=1)" 

    output = 0.0
    for l in 0:(n-m)÷2
        nom = (-1)^l*factorial(n-l)
        den = factorial(l)*factorial((n+m)÷2-l)*factorial((n-m)÷2-l)
        output += nom/den*r^(n-2*l)
    end

    return output
end
