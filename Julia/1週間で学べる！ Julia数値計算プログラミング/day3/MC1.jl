function MC(N)
    count = 0

    for n = 1:N
        x = rand() # 0から１までの乱数を生成する
        y = rand() # 0から１までの乱数を生成する
        r = x^2 + y^2

        count += ifelse(r > 1, 0, 1) # 距離 r が1より小さいときにカウントする
    end
    
    return 4*count/N
end

N = 10000
println(MC(N))
println(MC(N))
println(MC(N))
