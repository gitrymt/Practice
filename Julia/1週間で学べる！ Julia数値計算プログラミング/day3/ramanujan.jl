setprecision(150)

function Ramanujan(nc)
    a = 0
    for n=0:nc
        a += factorial(4n)*(1103+26390n) / (4^n*99^n*factorial(n))^4
    end
    return 99^2/(2*sqrt(2)*a)
end

r = Ramanujan(1)
println(r, "\t", abs(π-r)/π)

function Ramanujan_big(nc)
    a = 0
    for n=0:nc
        n = big(n)
        a += factorial(4n)*(1103+26390n) / (4^n*99^n*factorial(n))^4
    end
    return 99^2/(2*sqrt(big(2)) *a)
end

r_big = Ramanujan_big(4)
println(r_big, "\t", abs(π-r_big)/π)
