using Plots

mutable struct Ball_anim
    v::Float64
    x::Float64
    v_history::Array{Float64,1}
    x_history::Array{Float64,1}
    mass::Float64
    radius::Float64

    function Ball_anim(v,x,m,radius)
        v_history = Float64[]
        x_history = Float64[]
        push!(x_history, x)
        push!(v_history, v)
        return new(v,x,v_history,x_history,m,radius)
    end
end

function update!(ball::Ball_anim,x,v)
    ball.x = x
    ball.v = v
    push!(ball.x_history,x)
    push!(ball.v_history,v)
    return
end

function get_xv(ball::Ball_anim)
    return ball.x, ball.v
end

function ball_collision_time(small::Ball_anim,large::Ball_anim)
    t = (small.x+small.radius - (large.x-large.radius))/(large.v-small.v)
    return t
end

function wall_collision_time(small::Ball_anim)
    t = -(small.x-small.radius)/small.v
    return t
end

function collision_time(small::Ball_anim,large::Ball_anim)
    t_ball = ball_collision_time(small,large)
    t_wall = wall_collision_time(small)
    t = ifelse(t_ball > t_wall && t_wall > 0, t_wall, t_ball)
    return t
end

function check_collision!(small::Ball_anim,large::Ball_anim,timeseries)
    r = large.mass/small.mass
    x,v = get_xv(small)
    X,V = get_xv(large)
    told = timeseries[end] # 直前の衝突時刻

    if v > V # 小さい球の方が早ければ必ず衝突する
        t = collision_time(small,large) # 衝突時間の計算
        x += t*v # 軽い球の次の衝突地点
        X += t*V # 重い球の次の衝突地点
        V_next = (2v+(r-1)V)/(r+1)
        v_next = ((1-r)v+2r*V)/(r+1)
        collision = true
        
        update!(small, x,v_next)
        update!(large, X,V_next)
        push!(timeseries, told+t) # 衝突した時刻を記録
        
        return collision
    elseif v < 0 # 小さい球の速度が負なら必ず壁にぶつかる
        t = wall_collision_time(small) # 衝突時間の計算
        x += t*v # 軽い球の次の衝突地点
        X += t*V # 重い球の次の衝突地点
        collision = true

        update!(small, x,-v)
        update!(large, X,V)

        push!(timeseries, told+t) # 衝突した時刻を記録
        return collision
    else
        collision = false
        return collision
    end
end

function get_xv_anim(ball::Ball_anim,ith)
    return ball.x_history[ith], ball.v_history[ith]
end

function make_anime(small::Ball_anim,large::Ball_anim,timeseries,N)
    anim = Animation()
    ts = range(0.00001, timeseries[end]+0.1, length=200) # 描画するための時間刻み。全ての衝突が終了してから0.1 まで。点の数は200個。
    θ = range(0,2π,length=100)
    xcirc = small.radius*cos.(θ) # 球を描写するための角度の刻み
    ycirc = small.radius*sin.(θ) # 球を描写するための角度の刻み
    Xcirc = large.radius*cos.(θ) # 球を描写するための角度の刻み
    Ycirc = large.radius*sin.(θ) # 球を描写するための角度の刻み

    for t in ts
        ith = searchsortedfirst(timeseries,t)-1
        t0 = timeseries[ith]
        x,v = get_xv_anim(small,ith)
        X,V = get_xv_anim(large,ith)
        dt = t-t0
        x += v*dt
        X += V*dt
        count = ith-1
        plt = plot(x .+ xcirc,ycirc,label="count = $count, π = $(count/10^N)", xlim=(0,10),ylims=(-2,2),aspect_ratio=1)
        # x .+ xcirc は軽い球の表面のx座標
        plt = plot!(X .+ Xcirc,Ycirc,label=nothing, xlim=(0,10),ylims=(-2,2),aspect_ratio=1)
        frame(anim,plt)
    end
    gif(anim, "./day3/collision_anim_$(N).gif", fps=15)
end

function ballcollision(N)
    v0 = 0.0
    V0 = -1.0
    m = 1.0
    M = m*100^N
    radius_small = 0.1 # 軽い球の半径
    radius_large = 0.1*100^(N/3) # 重い球の半径（サイズは適当）
    X0 = 2.0 + radius_large
    x0 = 1.0
    smallball = Ball_anim(v0,x0,m,radius_small)
    largeball = Ball_anim(V0,X0,M,radius_large)
    timeseries = Float64[] # 衝突時刻を記録する配列
    push!(timeseries, 0) # 最初の時刻 0 を配列に代入
    collision = true
    count = 0
    while collision # collision が true である限り繰り返し続ける
        collision = check_collision!(smallball,largeball,timeseries)
        if collision
            count += 1 # collision が true ならカウントする
        end
    end
    
    make_anime(smallball,largeball,timeseries,N) # 得られた情報をもとにアニメーションを作成

    return count/10^N
end

N = 5
p = ballcollision(N)
println(p)