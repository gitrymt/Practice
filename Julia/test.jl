println("Hello World!")

a = sin(2π)
println("sin(2π) = $a")

a = sin(2*BigFloat(π))
println("Big float: sin(2π) = $a")

a = 4 + 5im
println("$a")
println("exp($a) = $(exp(a))")

println("$(1//2 + 1//3)")

using Plots

x = 1:10; y = rand(10); # These are the plotting data 
plot(x, y, label="my label")



