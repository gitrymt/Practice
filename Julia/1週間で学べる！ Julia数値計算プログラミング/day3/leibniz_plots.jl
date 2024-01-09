function Basel(nc)
    a = 0
    for n=1:nc
        a += 1/n^2
    end
    return sqrt(6a)
end

function Leibniz(nc)
    a = 0
    for n=0:nc
        a += (-1)^n/(2n+1)
    end
    return 4a
end

function test()
    ncs = [10^n for n=0:9]

    bs = []
    ls = []
    for nc in ncs # ncs という配列を1つずつ取り出して nc とする
        b = Basel(nc)
        l = Leibniz(nc)
        push!(bs,abs(π-b)/π)
        push!(ls,abs(π-l)/π)
    end
    println(bs)
    return ncs, bs, ls
end

using Plots
ncs, bs, ls = test()
plot(ncs,[bs,ls],xscale=:log10,yscale=:log10,markershape=[:circle :star5],label=["Basel" "Leibniz"],xlabel="cutoff num",ylabel="relative error")
savefig("./day3/leibniz_1.pdf")
plot(ncs,bs,xscale=:log10,yscale=:log10,markershape=:circle,label="Basel",xlabel="cutoff num",ylabel="relative error")
plot!(ncs,ls,xscale=:log10,yscale=:log10,markershape=:star5,label="Leibniz",xlabel="cutoff num",ylabel="relative error")
savefig("./day3/leibniz_2.pdf")