# Create example data file
# ExampleArray = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];
# open("ExampleArray_d1p1.txt", "w") do io
#     writedlm(io, [ExampleArray], ',')
# end;
# using DelimitedFiles
# Import example data file
# measures = readdlm("/Day 1/ExampleArray_d1p1.txt", ',', Int64)
# Import data file
# measures = readdlm("day1_p1_input.txt", ' ', Int64)

#Part 1
function depthmeasureincreases(measures)
    #create an Array offseting by the first integers (reduces the dim by 1)
    #A = [measures[1:end-1], measures[2:end]]??? produces 1-element Vec 
    #perform a diff operation between the elements in A
    D = measures[2:end] - measures[1:end-1]
    #Extract elements with positive values
    sch = 0;
    positives = filter( x -> x > sch, D )
    #find length of positives final count of depth increases
    count = length(positives)
end
 #p1 answer = 1301


# Part 2
#w = 3
#s = 1
#z = measures
#v = []
function windowedDepth(z,w,s)
    #z = measures
    #w = window
    #s = step
    for e in ((@view z[i:i+(w-1)]) for i in 1:s:length(z)-(w-1))
        #do something, try display(e)
        push!(v, sum(e))
        #display(e)
        #display(sum(e))
        #display(i)
    end
end
# Run windowedDepth on the data to generate a windowed vector v. Then run depthmeasureincreases
 #p2 answer = 1346

