# Import data file
# movement = readdlm("day2_input.txt", ' ')
# input = readdlm("day2_example.txt", ' ')

#Part 1
function location_estimate(input)
    #create an Array offseting by the first integers (reduces the dim by 1)
    horizontal = 0
    depth = 0
    for i in 1:length(input[:,1])
        if input[i,1] == "forward"
            horizontal = horizontal + input[i,2]
        elseif  input[i,1] == "down"
            depth = depth + input[i,2]
        else input[i,1] == "up"
            depth = depth - input[i,2]
        end
    end
    #println(horizontal)
    #println(depth)
    course = horizontal*depth;
    println(course)
end

# p1 = 1648020