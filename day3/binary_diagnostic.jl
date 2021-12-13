# binary = readlines("day3_example.txt")
# binary = readlines("day3_input.txt")
# using StatsBase

#Part 1
function power_consumption(input)
    #convert Vector{Strings} to a matrix of integers
    count = zeros(Int8,(length(input), length(input[1])))
    for i in 1:length(input)
        temp = split(input[i],"")
        for j in 1:length(temp)
            count[i,j] = parse(Int, temp[j])
        end        
    end
    #println(size(count))
    
    #calculate gamma
    gamma = zeros(Int8,1, length(input[1]))
    epsilon = zeros(Int8,1, length(input[1]))
    for i in 1:length(gamma)
        a = countmap(count[:,i])
        if a[0] > a[1]
            gamma[i] = 0
            epsilon[i] = 1
        else
            gamma[i] = 1
            epsilon[i] = 0
        end
    end
    #println(gamma)
    #println(epsilon)
    gamma_decimal = parse(Int, join(gamma),base=2)
    epsilon_decimal = parse(Int, join(epsilon),base=2)
    power = gamma_decimal*epsilon_decimal
    println(power)
end