# input = readlines("day4_example.txt")
# input = readlines("day4_example2.txt")
# input = readlines("day4_input.txt")
using StatsBase
using InvertedIndices

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

function first_play_bingo(input)
    # clean input file to be ready to play bingo
    (boards, draw_numbers) = sanitize_deck(input)
    #return (boards, draw_numbers)
    scores = zeros(Int8,5, 5,Int((length(input)-1)/6)); #initialize a blank matrix to store boolean scores 
    # 0 = number not 'called' and 1 = number called on the board
    for i in 1:length(draw_numbers)
        indx = findall(x->x==draw_numbers[i], boards) #find all CartesianIndex values that match the draw number
        scores[indx] .= 1 #replace all matching CartesianIndex with a 1

        scores_col = sum(scores, dims=1)
        scores_row = sum(scores, dims=2)

        scores_col_indx  = findall(x->x==5, scores_col)
        scores_row_indx  = findall(x->x==5, scores_row)
        
        if length(scores_col_indx) > 0 
            score_card = getindex.(scores_col_indx, 3)
            win_score_card = scores[:,:,score_card]
            win_board = boards[:,:,score_card]
            unmarked_indx  = findall(x->x==0, win_score_card)

            final_score = draw_numbers[i]*sum(win_board[unmarked_indx])
            #return (final_score)
            break
        elseif length(scores_row_indx) > 0 
            score_card = getindex.(scores_row_indx, 3)
            win_score_card = scores[:,:,score_card]
            win_board = boards[:,:,score_card]
            unmarked_indx  = findall(x->x==0, win_score_card)
            final_score = draw_numbers[i]*sum(win_board[unmarked_indx])
            return (final_score)
            break
        end
    end
end

#p1 answer = 44736

#Part 2
# using InvertedIndices

function last_play_bingo(input)
    # clean input file to be ready to play bingo by returning (boards, draw_numbers)
    (boards, draw_numbers) = sanitize_deck(input)
    
    scores = zeros(Int8,5, 5,Int((length(input)-1)/6)); #initialize a blank matrix to store boolean scores 
    final_score = 0;
    rank_inx = 0;

    # 0 = number not 'called' and 1 = number called on the board
    for i in 1:length(draw_numbers)
        indx = findall(x->x==draw_numbers[i], boards) #find all CartesianIndex values that match the draw number
        scores[indx] .= 1 #replace all matching CartesianIndex with a 1

        scores_col = sum(scores, dims=1) #sum across all columns for each board
        scores_row = sum(scores, dims=2) #sum across all row for each board

        scores_col_indx  = findall(x->x==5, scores_col) #find all indices of column sums that total 5 aka Bingo!
        scores_row_indx  = findall(x->x==5, scores_row) #find all indices of row sums that total 5 aka Bingo!

        # println(rank_inx)
        # println(i)
        # println(size(boards))
        # # println(boards)
        #println(final_score)
        
        # println(boards)
        if i == length(draw_numbers)
            return (final_score)
            break

        elseif length(scores_col_indx) > 0 
            score_card = getindex.(scores_col_indx, 3)
            win_score_card = scores[:,:,score_card]
            win_board = boards[:,:,score_card]
            unmarked_indx  = findall(x->x==0, win_score_card)

            final_score = draw_numbers[i]*sum(win_board[unmarked_indx])
            # println(final_score)
            # println(scores[:,:,score_card])
            s = size(boards)
            if s[3] == 1
                return (final_score)
                break
            else
                scores =  scores[:,:,Not(score_card)]
                boards =  boards[:,:,Not(score_card)]

                rank_inx = rank_inx-1;
            end

            # println(score_card)
            # println(rank_inx)
            # println(draw_numbers[i])
            # println(scores)
        elseif length(scores_row_indx) > 0 
            score_card = getindex.(scores_row_indx, 3)
            win_score_card = scores[:,:,score_card]
            win_board = boards[:,:,score_card]
            unmarked_indx  = findall(x->x==0, win_score_card)
            
            final_score = draw_numbers[i]*sum(win_board[unmarked_indx])
            # println(final_score)
            # println(scores[:,:,score_card])
            s = size(boards)
            if s[3] == 1
                return (final_score)
                break
            else
                scores =  scores[:,:,Not(score_card)]
                boards =  boards[:,:,Not(score_card)]

                rank_inx = rank_inx-1;
            end
            # println(score_card)
            # println(rank_inx)
            # println(draw_numbers[i])
            # println(scores)
        end
    end
end

function main()
    test_input =  readlines("day4_example.txt")
    main_input =  readlines("day4_input.txt")
  
    @assert first_play_bingo(test_input) == 4512
    @assert last_play_bingo(test_input) == 1924
  
    @show first_play_bingo(main_input) # 44736
    @show last_play_bingo(main_input) # 1827 
end
  
@time main()