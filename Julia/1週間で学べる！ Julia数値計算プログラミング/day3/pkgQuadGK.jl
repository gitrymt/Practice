using QuadGK

f(x) = 4/(1+x^2)
result = quadgk(f, 0, 1)
println(result[1], "\t error: ", result[2])

# function test()
#     ncs = [10^n for n=0:9]

#     results = []

#     for nc in ncs # ncs という配列を1つずつ取り出して nc とする
#         b = Kubun(nc, 0, 1, f)
#         push!(results,abs(π-b)/π)
#     end
#     println(results)
#     return ncs, results
# end

# using Plots
# ncs, results = test()
# plot(ncs,results,xscale=:log10,yscale=:log10,markershape=:circle,label="Kubun",xlabel="cutoff num",ylabel="relative error")
