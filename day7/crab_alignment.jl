
function crab_optimizer(input)

    input .+= 1 #shift the inputs by 1 to avoid 0 index
    maximum = findmax(input)
    minimum = findmin(input)

    alignment = zeros(Int, minimum[1], maximum[1]) #create an empty array that is bounded by min and max distances
    # [crabs[n] += 1 for n in input[1, :]] #count the number of crabs at a given location 
    for i = minimum[1]:maximum[1]
        alignment[i] = sum(broadcast(abs, input .- i))
    end
    fuel = findmin(alignment)
    return fuel[1]
end

function crab_optimizer_part2(input)
    input .+= 1 #shift the inputs by 1 to avoid 0 index
    maximum = findmax(input)
    minimum = findmin(input)

    alignment = zeros(Int, minimum[1], maximum[1]) #create an empty array that is bounded by min and max distances

    

end

function main()
    test_state = readdlm("day7_example.txt", ',', Int)
    main_state =  readdlm("day7_input.txt", ',', Int)

    @assert crab_optimizer(test_state) == 37
    @assert crab_optimizer_part2(test_state)  == 168
  
    @show crab_optimizer(main_state) # 360761
    #@show lanternfish_model_xl(main_state, main_input) # 1632779838045 
end
  
@time main()