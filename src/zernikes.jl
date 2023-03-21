## W = sum_j C_j*Z_j(r,x,y) = sum_(n,m) C_n^m*Z_n^m(r,theta)
# x = r*sin(theta)
# y = r*cos(theta)

# Z_n^m(r,theta) = R_n^m(r)*cos(m*theta) if m >= 0
# Z_n^-m(r,theta) = R_n^m(r)*sin(m*theta) if m < 0
# NOTE: theta is measured clockwise from the y-axis. This is consistent with aberration theory, but different from conventional mathematical definition

function R(r::Real; n::Int,m::Int)::Real
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

function Z(r::Real, theta::Real; n::Int, m::Int)::Real
    if m >= 0
        output = R.(r; n=n, m=m).*cos(m*theta)
    else
        output = R.(r; n=n, m=-m).*sin(-m*theta)
    end
    return output
end

function double2single_index(n, m)::Int
    return (n * (n+2)+ m)/2
end

function single2double_index(j)::Tuple{Int, Int}
    n = ceil((-3 + (9 + 8*j)^(1/2))/2)
    m = 2*j - n * (n+2)
    return (n,m)
end