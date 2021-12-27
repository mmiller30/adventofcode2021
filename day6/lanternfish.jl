using DelimitedFiles

function lanternfish_model(initial_state, input)  
    
    state = initial_state;
    for d in 1:input
        indx = findall(x->x==0, state) #find all CartesianIndex values that match the draw number
        new_fish = ones(Int,1,length(indx)).*8 #create a vec of new fish with value 8
        state = state .- 1 #reduce the timer of all fish by 1
        state[indx] .= 6 #reset the timers of all 0 fish to 6
        state = append!(vec(state),vec(new_fish))' #append the new fish to the next state
    end
    s = size(state)
    return s[2]
end

function main()
    test_state = readdlm("day6_example.txt", ',', Int)
    main_state =  readdlm("day6_input.txt", ',', Int)

    input = 80
    #input = 256

    @assert lanternfish_model(test_state, input)  == 5934
    # @assert lanternfish_model(test_state, input)  == 26984457539
  
    # @show lanternfish_model(main_state, input) # 360761
    # @show lanternfish_model(main_state, input) # 1827 
end
  
@time main()