using FunctionZeros
using QuadGK
using Plots

function calc_Vij(n,i,j,R,V)
    αi = besselj_zero(n,i)
    αj = besselj_zero(n,j)
    f(r) = r*V(R*r)*besselj(n,αi*r)*besselj(n,αj*r)
    v,err = quadgk(f,0,1)
    Vij = v*2/besselj(n+1,αi)^2

    return Vij
end

function make_H(n,V,N,R)
    H = zeros(Float64,N,N)
    for i=1:N
        αi = besselj_zero(n,i)

        for j=1:N
            if i==j
                H[i,i] += αi^2/R^2
            end

            Vij = calc_Vij(n,i,j,R,V)
            H[i,j] += Vij
        end
    end

    return H
end

function calc_psi(ci,n,r,R)
    N = length(ci)
    psi = 0
    for i = 1:N
        αi = besselj_zero(n,i)
        psi += ci[i]*besselj(n,αi*r/R)
    end

    return psi
end

function test4()
    R = 10
    V(r) = 2*exp(-(r-R/4)^2/(R/20)^2)
    N = 30
    n = 0
    H = make_H(n,V,N,R)
    e,v = eigen(H)
    println(e)

    Nx = 100
    xs = range(0,10,length=Nx)
    i1 = 1
    i2 = 2
    psis1 = zero(xs) # xs と同じサイズで中身がゼロの配列を作る
    psis2 = zero(xs) # xs と同じサイズで中身がゼロの配列を作る

    for (j,x) in enumerate(xs)
        psis1[j] = calc_psi(v[:,i1],n,x,R)
        psis2[j] = calc_psi(v[:,i2],n,x,R)
    end

    plot(xs,psis1,label="$i1-th eigenvalue")
    plot!(xs,psis2,label="$i2-th eigenvalue")

    V_none(r) = 0
    H = make_H(n,V_none,N,R)
    e,v = eigen(H)
    println(e)

    psis1 = zero(xs) # xs と同じサイズで中身がゼロの配列を作る
    psis2 = zero(xs) # xs と同じサイズで中身がゼロの配列を作る

    for (j,x) in enumerate(xs)
        psis1[j] = calc_psi(v[:,i1],n,x,R)
        psis2[j] = calc_psi(v[:,i2],n,x,R)
    end

    plot!(xs,psis1,label="No potential: $i1-th eigenvalue", ls=:dash)
    plot!(xs,psis2,label="No potential: $i2-th eigenvalue", ls=:dash)

    savefig("./day4/4_2_3_JV.png")
end

test4()
