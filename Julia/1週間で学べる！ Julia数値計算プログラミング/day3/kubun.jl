function Kubun(N,x0,x1,f)
    dx = (x1-x0)/N
    a = 0.0
    xn = range(x0, step=dx, length=N)
    for x in xn
        a += f(x)
    end
    
    return a*dx
end

f(x) = 4/(1+x^2)
N = 1000000
p = Kubun(N, 0, 1, f)
println(p)

function test()
    ncs = [10^n for n=0:9]

    results = []

    for nc in ncs # ncs という配列を1つずつ取り出して nc とする
        b = Kubun(nc, 0, 1, f)
        push!(results,abs(π-b)/π)
    end
    println(results)
    return ncs, results
end

using Plots
ncs, results = test()
plot(ncs,results,xscale=:log10,yscale=:log10,markershape=:circle,label="Kubun",xlabel="cutoff num",ylabel="relative error")
