using Random

function MC(N;seed=10)
    Random.seed!(seed)
    count = 0

    for n = 1:N
        x = rand() # 0から１までの乱数を生成する
        y = rand() # 0から１までの乱数を生成する
        r = x^2 + y^2

        count += ifelse(r > 1, 0, 1) # 距離 r が1より小さいときにカウントする
    end
    
    return 4*count/N
end

N = 10000
println(MC(N))
println(MC(N))
println(MC(N))

using Plots

function test()
    ncs = [10^n for n=0:9]
    ms = []

    for nc in ncs # ncs という配列を1つずつ取り出して nc とする
        m = MC(nc)
        push!(ms,abs(π-m)/π)
    end
    println(ms)
    return ncs, ms
end

ncs, results = test()
plot(ncs,results,xscale=:log10,yscale=:log10,markershape=:circle,label="Monte Carlo",xlabel="num",ylabel="relative error")
