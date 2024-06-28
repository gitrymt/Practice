using FunctionZeros
using QuadGK
using Plots

function orthoij(n,i,j)
    αi = besselj_zero(n,i)
    αj = besselj_zero(n,j)
    f(x) = x*besselj(0,αi*x)*besselj(0,αj*x)
    dij, err = quadgk(f,0,1)
    
    return dij
end

function test3()
    i = 1
    j = 1
    n = 0
    dij = orthoij(n,i,j)
    αi = besselj_zero(n,i)
    println(dij[1]*2/besselj(1,αi)^2)
    
    i = 1
    j = 2
    dij = orthoij(n,i,j)
    αi = besselj_zero(n,i)
    println(dij[1]*2/besselj(1,αi)^2)
end

test3()
