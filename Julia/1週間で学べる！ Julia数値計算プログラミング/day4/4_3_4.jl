using SparseArrays
using KrylovKit

function make_H!(H,N,L,V)
    @. H = 0
    Δx = L/(N+1)

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

    return
end

function timeevolv(ψ,N,Nt,Δt,H::SparseMatrixCSC)
    ψs = zeros(ComplexF64,N,Nt) # 各時刻での波動関数を保存しておく
    A = im*Δt*H
    A += I(N)

    for i=1:Nt
        ψ = A \ ψ
        ψs[:,i] = ψ
    end

    return ψs
end

function timeevolv(ψ,N,Nt)
    anim = Animation()
    N = 4000
    L = 40.0
    xs = range(0, L, length=N)
    σ = 1
    k0 = 10
    ψ0 = zeros(ComplexF64, N)
    x0 = 5
    @. ψ0 = (π*σ^2)^(-1/4)*exp(-(xs-x0)^2/(2σ^2)+im+k0*(xs-x0))
    dx = (xs[2]-xs[1])/N
    V(x) = 0
    H = spzeros(Float64,N,N)
    make_H!(H,N,L,V)
    Δt = 0.02

    Nt = 100
    c = sqrt(norm(ψ0)^2*dx) # 規格化定数
    ψ = ψ0/c
    ψ2max = maximum(abs.(ψ).^2) # 波動関数の絶対値の最大値

    println("norm = $(norm(ψ)^2*dx)")
    @time ψs = timeevolv(ψ,N,Nt,Δt,H)

    Plots.CURRENT_PLOT.nullableplot = nothing
    for i=1:Nt
        plt = plot(xs,abs.(ψs[:,i]).^2,ylim=(0,ψ2max))
        println("$i-th: norm=$(norm(ψs[:,i])^2*dx)")
        frame(anim,plt)
    end
    gif(anim,"./day4/4_3_2.gif",fps=30)
end

timedep_simple()