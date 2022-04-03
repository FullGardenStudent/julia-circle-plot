using Plots  #load the Plots module https://docs.juliaplots.org/latest/tutorial/

@userplot PlotSin  # create a user recipe for plots
@userplot PlotSinc

@recipe function pl(cp::PlotSin)                # define a recipe function for sin and cos functions
    x,i,lab = cp.args                           # declare the arguments
    inds = circshift(1:length(x), i-1)          # shift the array elements for alpha line transition
    label --> lab                               # graphs settings
    ylabel --> lab
    xlabel --> "t"
    title --> lab
    seriesalpha --> range(1,0, length(x))
    dpi --> 300
    xtickfontsize --> 1
    xtickfontcolor --> "white"
    x[inds]                                     # return value
end

@recipe function pp(cp::PlotSinc)               # define a recipe for circle
    x, y, i = cp.args                           # declare the function artguments
    n = length(x)                               # get the size of x and y arrays
    inds = circshift(1:length(x), 1-i)          # shifts the array elements for alpha line transition
    aspect_ratio --> 1                          # settings for ploting
    title --> "Circle"
    label --> "(sin(t),cos(t))"
    xlabel --> "sin(t)"
    ylabel --> "cos(t)"
    dpi --> 300
    seriesalpha --> range(0, 1, n)
    x[inds], y[inds]
end

n = 300                                         # number of frames
t = 0:pi/200:2*pi                               # range of the cricle, 0 to 2*pi in pi/200 setps
x = sin.(t)                                     # defining x and y for the circle
y = cos.(t)

anim = @animate for i ∈ 1:n    # @animate macro returns Animation object and runs from 1 to n, rendering every iteration to a frame
    #define three plots for sin(t), cos(t) and circle, which will animate w.r.t i as time per frame
    plot(plotsin(x, i*4,"sin(t)"),plotsin(y,i*4,"cos(t)"),plotsinc(x,y,i*4))
end

# creaet a gif out of the animated frames
gif(anim, "circle_anim30.gif", fps = 30)
