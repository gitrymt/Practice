function make_H(N,L,V)
    Δx = L / (N+1)
    H = zeros(Float64,N,N)

    for i=1:N
        x = i*Δx
        H[i,i] = V(x)
        
        j = i+1
        dij = -1/Δx^2
        if 1 ≤ j ≤ N
            H[i,j] += dij
        end

        j = i
        dij = 2/Δx^2
        if 1 ≤ j ≤ N
            H[i,j] += dij
        end

        j = i-1
        dij = -1/Δx^2
        if 1 ≤ j ≤ N
            H[i,j] += dij
        end
    end

    return H
end

using LinearAlgebra
using Plots

function test()
    V(x) = 0
    N = 1000
    L = 1
    H = make_H(N, L, V)

    e, v = eigen(H)
    e0 = zeros(Float64, N)
    for n = 1:N
        e0[n] = n^2*π^2/L^2 # 解析解
    end

    println(e0[1],"\t",e[1])
    plot(1:N, [e,e0], labels=["Numerical result" "Analytical result"], xlabel="n", ylabel="energy")
end

test()
