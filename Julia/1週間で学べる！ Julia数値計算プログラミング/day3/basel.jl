function Basel(nc)
    a = 0
    for n=1:nc
        a += 1/n^2
    end
    return sqrt(6a)
end

function test()
    ncs = [1,10,100,1000,10000]

    for nc in ncs # ncs という配列を1つずつ取り出して nc とする
        b = Basel(nc)
        println("バーゼル級数和 (nc = $nc): ", b, "\t", abs(π-b)/π)
    end
end

test()