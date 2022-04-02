using Plots

@userplot PlotSin
@userplot PlotSinc

@recipe function pl(cp::PlotSin)
    x,i,lab = cp.args
    label --> lab
    ylabel --> lab
    xlabel --> "t"
    title --> lab
    inds = circshift(1:length(x), i-1)
    seriesalpha --> range(1,0, length(x))
    dpi --> 300
    xtickfontsize --> 1
    xtickfontcolor --> "white"
    x[inds]
end

@recipe function pp(cp::PlotSinc)
    x, y,lab, i = cp.args
    n = length(x)
    m = length(y)
    aspect_ratio --> 1
    title --> "Circle"
    inds = circshift(1:length(x), 1-i)
    ind = circshift(1:length(y),1-i)
    label --> lab
    xlabel --> "sin(t)"
    ylabel --> "cos(t)"
    dpi --> 300
    seriesalpha --> range(0, 1, n)
    x[inds], y[ind]
end

n = 300
t = 0:pi/200:2*pi
x = sin.(t)
y = cos.(t)

anim = @animate for i ∈ 1:n
    plot(plotsin(x, i*4,"sin(t)"),plotsin(y,i*4,"cos(t)"),plotsinc(x,y,"(sin(t),cos(t))",i*4, framestyle = :zerolines))
end

gif(anim, "circle_anim30.gif", fps = 30)
