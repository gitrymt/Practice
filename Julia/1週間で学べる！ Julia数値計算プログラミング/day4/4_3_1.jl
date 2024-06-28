function timeevolv(ψ,N,Nt,Δt,H)
    ψs = zeros(ComplexF64,N,Nt)
    U = exp(-im*Δt*H)
    for i=1:Nt
        ψ = U*ψ
        ψs[:,i] = ψ
    end

    return ψs
end

function timedep_simple()
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
    H = make_H(N,L,V)
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
    gif(anim,"./day4/4_3_1.gif",fps=30)
end

timedep_simple()