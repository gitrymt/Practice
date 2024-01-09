function sankaku()
    setprecision(100)
    c = BigFloat(sqrt(2)/2) # cos 45° の値
    hankakucos(c) = sqrt((1+c)/2) # 半角の公式による cos の計算
    n = 30
    N = 8

    for i=1:n
        c = hankakucos(c) # 半角の公式を使って繰り返し角度を小さくしていく
        N = N*2
        l = sqrt(2 - 2*c)
        println("正$(N)角形の場合: ", N*l/2, "\t", abs(π - N*l/2)/π)
    end
end

sankaku()