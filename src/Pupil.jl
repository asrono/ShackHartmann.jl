using PlotlyJS
struct Pupil
    x::Vector{Real}
    y::Vector{Real}
    wavefront::Matrix{Complex}
end

Pupil() = Pupil(Vector{Real}(), Vector{Real}(), Matrix{Complex}([;;]))

function plot_pupil(P::Pupil)
    s1 = heatmap(z = abs.(P.wavefront)^2, x=P.x, y=P.y)
    l1 = Layout(title="Abs(Pupil)^2")
    p1 = plot(s1,l1)

    s2 = heatmap(z = angle.(P.wavefront), x=P.x, y=P.y)
    l2 = Layout(title="Phase(Pupil)^2")
    p2 = plot(s2,l2)

    return [p1; p2]
end