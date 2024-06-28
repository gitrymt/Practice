using LinearAlgebra
using Plots

function calc_vq(q, ξ, V0)
    vq = sqrt(π*ξ^2) * exp(-q^2*ξ^2/4)
    return vq
end

function calc_Vkkp(k,kp,L,ξ,x0,V0)
    q1 = k - kp
    vq1 = calc_vq(q1, ξ, V0)
    q2 = k + kp
    vq2 = calc_vq(q2, ξ, V0)
    Vkkp = (V0/L) * (cos(q1*x0)*vq1 - cos(q2*x0)*vq2)
    
    return Vkkp
end

function make_Hk(N,L,ξ,x0,V0)
    mat_Hk = zeros(Float64,N,N)

    for n in 1:N
        k = n*π/L
        for np in 1:N
            if n == np
                v = k^2
            else
                v = 0
            end

            kp = np*π/L
            Vkkp = calc_Vkkp(k,kp,L,ξ,x0,V0)
            v += Vkkp
            mat_Hk[n,np] = v
        end
    end

    return mat_Hk
end

function calc_psi(cn,x,L)
    nmax = length(cn)
    psi = 0
    for n = 1:nmax
        kn = n*π/L
        psi += cn[n]*sin(kn*x)
    end

    return psi*sqrt(2/L)
end

function momentumspace(N,L,ξ,x0,V0)
    Hk = make_Hk(N,L,ξ,x0,V0)
    ep, bn = eigen(Hk)
    xs = range(0,L,length=N)
    psi = zeros(Float64, N)
    n = 1
    
    for (i,x) in enumerate(xs)
        psi[i] = calc_psi(bn[:,n],x,L)
    end

    plot(xs, psi, label="Numerical result in momentum space: n=1", xlabel="x", ylabel="ψ(x)")
end

N = 1000
L = 10
ξ = 1
x0 = L/2
V0 = 1

momentumspace(N,L,ξ,x0,V0)