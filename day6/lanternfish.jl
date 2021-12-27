using DelimitedFiles

function lanternfish_model(initial_state, input)  
    
    state = initial_state;
    for d in 1:input
        indx = findall(x->x==0, state) #find all CartesianIndex values of fish length 0
        new_fish = ones(Int,1,length(indx)).*8 #create a vec of new fish with value 8
        state = state .- 1 #reduce the timer of all fish by 1
        state[indx] .= 6 #reset the timers of all 0 fish to 6
        state = append!(vec(state),vec(new_fish))' #append the new fish to the next state
    end
    s = size(state)
    return s[2]
end

function lanternfish_model_xl(initial_state, input)  
    # credit: https://github.com/Praful/advent_of_code/blob/main/2021/src/day06.jl 
    # where zero count is stored; can't be element 0 since Julia arrays starts at 1
    ZERO = 9
    
    state = initial_state;
    # fish[timer value] = number of fish with that timer value.
    fish = zeros(Int, 9)
    [fish[n] += 1 for n in state[1, :]] #count the number of timers for each bin
    
    for d in 1:input
        new_fish = fish[ZERO] #get the zero count
        fish[ZERO] = fish[1] #take the count of 1 timers and place in zero count 
        [fish[c] = fish[c+1] for c = 1:7] #shift the count of timers by 1
        fish[6] += new_fish #increase the timer 6 count by the new fish count
        fish[8] = new_fish #add the new fish to the timer 8
    end
    sum(fish[1:9])
end

function main()
    test_state = readdlm("day6_example.txt", ',', Int)
    main_state =  readdlm("day6_input.txt", ',', Int)

    test_input = 80
    main_input = 256

    @assert lanternfish_model_xl(test_state, test_input) == 5934
    @assert lanternfish_model_xl(test_state, main_input)  == 26984457539
  
    @show lanternfish_model_xl(main_state, test_input) # 360761
    @show lanternfish_model_xl(main_state, main_input) # 1632779838045 
end
  
@time main()