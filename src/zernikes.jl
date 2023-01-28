## W = sum_j C_j*Z_j(r,x,y) = sum_(n,m) C_n^m*Z_n^m(r,theta)
# x = r*sin(theta)
# y = r*cos(theta)

# Z_n^m(r,theta) = R_n^m(r)*cos(m*theta) if m >= 0
# Z_n^-m(r,theta) = R_n^m(r)*sin(m*theta) if m < 0
# NOTE: theta is measured clockwise from the y-axis. This is consistent with aberration theory, but different from conventional mathematical definition

function R(n,m,r)
    return 0
end
