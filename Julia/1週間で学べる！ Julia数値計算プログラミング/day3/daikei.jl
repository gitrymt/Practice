function Daikei(N,x0,x1,f)
    dx = (x1-x0)/N
    a = (f(x0)+f(x1))/2
    xn = range(x0, step=dx, length=N)
    for n = 2:N
        x = xn[n]
        a += f(x)
    end
    
    return a*dx
end

f(x) = 4/(1+x^2)
N = 1000000
p = Daikei(N, 0, 1, f)
println(p)

function test()
    ncs = [10^n for n=0:9]

    results = []

    for nc in ncs # ncs という配列を1つずつ取り出して nc とする
        b = Daikei(nc, 0, 1, f)
        push!(results,abs(π-b)/π)
    end
    println(results)
    return ncs, results
end

using Plots
ncs, results = test()
plot(ncs,results,xscale=:log10,yscale=:log10,markershape=:circle,label="Daikei",xlabel="cutoff num",ylabel="relative error")
