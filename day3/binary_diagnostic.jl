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
    
    #calculate gamma and epsilon
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

    #calculate power
    gamma_decimal = parse(Int, join(gamma),base=2)
    epsilon_decimal = parse(Int, join(epsilon),base=2)
    power = gamma_decimal*epsilon_decimal
    println(power)
end

#p1 solution = 3985686

#Part 2
function lift_support_rating(input)
    #convert Vector{Strings} to a matrix of integers
    count = zeros(Int8,(length(input), length(input[1])))
    for i in 1:length(input)
        temp = split(input[i],"")
        for j in 1:length(temp)
            count[i,j] = parse(Int, temp[j])
        end        
    end
    #println(count)
    #count
    
    #calculate oxygen
    ox_count = count
    index = length(ox_count[:,1])
    while true
        for i in 1:length(ox_count[1,:])
            a = countmap(ox_count[:,i])
            if a[0] > a[1]
                ox_count = ox_count[(ox_count[:,i] .== 0),:]
                index = length(ox_count[:,1])
            elseif a[0] == a[1]
                ox_count = ox_count[(ox_count[:,i] .== 1),:]
                index = length(ox_count[:,1])
            elseif a[0] < a[1]
                ox_count = ox_count[(ox_count[:,i] .== 1),:]
                index = length(ox_count[:,1])
            end
            #println(ox_count)
        end
        if index == 1
            break
        end
    end
    
    #calculate co2
    co2_count = count
    index = length(co2_count[:,1])
    while true
        #global index = length(co2_count[:,1])
        for i in 1:length(co2_count[1,:])
            #println(index)
            a = countmap(co2_count[:,i])
            if index == 1
                break
            elseif a[0] < a[1]
                co2_count = co2_count[(co2_count[:,i] .== 0),:]
                index = length(co2_count[:,1])
            elseif a[0] == a[1]
                co2_count = co2_count[(co2_count[:,i] .== 0),:]
                index = length(co2_count[:,1])
            elseif a[0] > a[1]
                co2_count = co2_count[(co2_count[:,i] .== 1),:]
                index = length(co2_count[:,1])
            end
            #println(co2_count)
        end
        if index == 1
            break
        end
    end
    # println(ox_count)
    # println(co2_count)
    
    #calculate life support rating
    oxygen = parse(Int, join(ox_count),base=2)
    co2 = parse(Int, join(co2_count),base=2)
    rating = oxygen*co2
    println(rating)
end

#p2 solution: 2555739