include("original.jl")

function tasu(a,b)
    println("tasu in main.jl")
    return a+2b
end

println(supercoolfunction(4,10)," in main.jl")