using FunctionZeros
using Plots

function test2()
    R = 10
    N = 100
    Nene = 5
    n = 0
    Es = besselj_zero.(n, 1:Nene).^2/R^2 # E = α^2/R^2
    xs = range(0, 10, length=N)
    
    Plots.CURRENT_PLOT.nullableplot = nothing
    for (i,E) in enumerate(Es)
        J0 = besselj.(0,xs*sqrt(E))
        plot!(xs,J0,label="$i-th eigenvalue",ylims=(-1,1))
    end

    savefig("./day4/4_2_2_J0.png")
end

test2()