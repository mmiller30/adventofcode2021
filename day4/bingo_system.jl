# deck = readlines("day4_example.txt")
# deck = readlines("day4_input.txt")

#Part 1

# Sanitize the input deck for processing
function sanitize_deck(input)
    #Isolate the draw numbers as a vector of integers
    draw_numbers = [parse(Int, ss) for ss in split(input[1],",")];
    
    #Isolate the bingo boards as a (5 x 5 x # of boards) matrix of integers
    boards = zeros(Int8,5, 5,Int((length(input)-1)/6)); #initialize a blank matrix to store each board
    board = zeros(Int8,5,5); #initialize a blank single board for housing the vec(int) values
    n_boards = 1;
    for i in 3:6:length(input) #iterate over the starting line of each board
        for j in 1:5 #iterate over the rows within each board
            board[:,j] = [parse(Int, ss) for ss in split(input[(j-1)+i])] #parse each line of strings to vec(int)
        end
        boards[:,:,n_boards] = board' #input the vec(int) board into the full set of boards
        board = zeros(Int8,5,5) #reinitialize the empty board for the next round
        n_boards = n_boards + 1 #iterate on the next board
    end

    return (boards, draw_numbers)
end

