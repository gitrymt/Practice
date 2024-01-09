function Basel(nc)
    a = 0
    for n=1:nc
        a += 1/n^2
    end
    return sqrt(6a)
end

function test()
    ncs = [10^n for n=0:9]

    bs = []
    for nc in ncs # ncs という配列を1つずつ取り出して nc とする
        b = Basel(nc)
        push!(bs,abs(π-b)/π)
    end
    println(bs)
    return ncs, bs
end

using Plots
ncs, bs = test()
plot(ncs,bs)
savefig("./day3/basel.pdf")
plot(ncs,bs,xscale=:log10,yscale=:log10,markershape=:circle,label="Basel",xlabel="cutoff num",ylabel="relative error")
savefig("./day3/basellog.pdf")