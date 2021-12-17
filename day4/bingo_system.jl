# deck = readlines("day4_example.txt")
# deck = readlines("day4_input.txt")

#Part 1

# Sanitize the input deck for processing
function sanitize_deck(input)
    #Isolate the draw numbers as a vector of integers
    draw_numbers = [parse(Int, ss) for ss in split(input[1],",")];
    
    #Isolate the bingo boards as a (5 x 5 x # of boards) matrix of integers
    boards = zeros(Int8,5, 5,Int((length(input)-4)/5));
    board = zeros(Int8,5,5);
    n_boards = 1;
    for i in 3:6:length(input)
        for j in 1:5
            board[:,j] = [parse(Int, ss) for ss in split(input[(j-1)+i])]
        end
        boards[:,:,n_boards] = board'
        board = zeros(Int8,5,5)
        n_boards = n_boards + 1
    end

    return (boards, draw_numbers)
end