mutable struct Ball
    v::Float64
    mass::Float64
end

function check_collision!(small::Ball,large::Ball)
    r = large.mass/small.mass
    v = small.v
    V = large.v

    if v > V # 小さい球の方が早ければ必ず衝突する
        V_next = (2v+(r-1)V)/(r+1)
        v_next = ((1-r)v+2r*V)/(r+1)
        collision = true

        small.v = v_next
        large.v = V_next
        return collision
    elseif v < 0 # 小さい球の速度が負なら必ず壁にぶつかる
        collision = true
        small.v = -v
        return collision
    else
        collision = false
        return collision
    end
end

function ballcollision(N)
    v0 = 0.0
    V0 = -1.0
    m = 1
    M = m*100^N
    smallball = Ball(v0,m)
    largeball = Ball(V0,M)
    collision = true
    count = 0
    while collision # collision が true である限り繰り返し続ける
        collision = check_collision!(smallball,largeball)
        if collision
            count += 1 # collision が true ならカウントする
        end
    end
    
    return count/10^N
end

N = 5
p = ballcollision(N)
println(p)