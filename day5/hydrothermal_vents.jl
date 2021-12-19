using StatsBase
using DelimitedFiles

# input = readlines("day5_example.txt")
function sanitize_input(input)
    #create empty int array
    paths = zeros(Float64,length(input),4);
    for i = 1:length(input)
        #split the first and second pair of coordinates
        pairs = split(input[i], (" -> "))
        #split the first and second pair of coordinates and convert to int
        p1 = [parse(Float64, ss) for ss in split(pairs[1],",")];
        p2 = [parse(Float64, ss) for ss in split(pairs[2],",")];
        #store each individual coordinate in paths array [x1,y1,x2,y2]
        paths[i,1] = p1[1]
        paths[i,2] = p1[2]
        paths[i,3] = p2[1]
        paths[i,4] = p2[2]
    end
    return (paths)
end

function find_horizontal_vertical(input)
    paths = sanitize_input(input)

    for i = 1:length(paths[:,1])
        if paths[i,1] != paths[i,3] && paths[i,2] != paths[i,4]
            paths[i,:] .= NaN
        end
    end
    return paths
end

function vent_count(input)
    paths = find_horizontal_vertical(input)

    paths = paths .+ 1 #shift values by one so that '0' index is '1'
    vent_map = zeros(Float64,1000,1000); #establish the map
    for i = 1:length(paths[:,1])
        if !isnan(paths[i,1]) && paths[i,1] != paths[i,3] && paths[i,2] == paths[i,4]
            if paths[i,1] > paths[i,3]
                x_dir = collect(Int,paths[i,3]:paths[i,1])
            else
                x_dir = collect(Int,paths[i,1]:paths[i,3])
            end
            y_dir = Int(paths[i,2]) 
            for j = 1:length(x_dir)
                vent_map[y_dir,x_dir[j]] = vent_map[y_dir,x_dir[j]] + 1
            end
        elseif !isnan(paths[i,1]) && paths[i,2] != paths[i,4] && paths[i,1] == paths[i,3]
            if paths[i,2] > paths[i,4]
                y_dir = collect(Int,paths[i,4]:paths[i,2])
            else
                y_dir = collect(Int,paths[i,2]:paths[i,4])
            end
            x_dir = Int(paths[i,1])
            for j = 1:length(y_dir)
                vent_map[y_dir[j],x_dir] = vent_map[y_dir[j],x_dir] + 1
            end
        end
        #println(i)
    end
    indx = findall(x->x > 1, vent_map) #find all CartesianIndex values that match the draw number
    overlap_count = length(indx) #replace all matching CartesianIndex with a 1
    return overlap_count
end

function main()
    test_input =  readlines("day5_example.txt")
    main_input =  readlines("day5_input.txt")
  
    @assert vent_count(test_input) == 5
    #@assert last_play_bingo(test_input) == 12
  
    @show vent_count(main_input) # 7436
    #@show last_play_bingo(main_input) # 1827 
end
  
@time main()