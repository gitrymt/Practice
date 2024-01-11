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

function test2()
    V(x) = 0
    N = 1000
    L = 1
    H = make_H(N, L, V)

    e, v = eigen(H)

    Δx = L/(N+1)
    xs = zeros(Float64, N)
    ψ0 = zeros(Float64, N)
    ψ250 = similar(ψ0)
    n = 1
    m = 250

    for i = 1:N
        x = i*Δx
        xs[i] = x
        ψ0[i] = sqrt(2/L)*sin(x*n*π/L)
        ψ250[i] = sqrt(2/L)*sin(x*m*π/L)
    end

    coeff = 1/sqrt(Δx) # 規格化条件をそろえる

    plot(xs, coeff*v[:,n], label="Numerical result: n=1", xlabel="x", ylabel="ψ(x)")
    plot!(xs, ψ0, label="Analytical result: n=1", xlabel="x", ylabel="ψ(x)")
    plot!(xs, coeff*v[:,m], label="Numerical result: n=250", xlabel="x", ylabel="ψ(x)")
    plot!(xs, ψ250, label="Analytical result: n=250", xlabel="x", ylabel="ψ(x)")
end

test2()