using SpecialFunctions
using Plots

function test()
    N = 100
    xs = range(0, 10, length=N)
    
    Plots.CURRENT_PLOT.nullableplot = nothing
    for n = 0:3
        Jn = besselj.(n,xs)
        Yn = bessely.(n,xs)
        plot!(xs,Jn,label="J$n(x)",ylims=(-1,1))
        plot!(xs,Yn,label="Y$n(x)",ylims=(-1,1))
    end

    savefig("./day4/4_2_1_JY.png")
end

test()