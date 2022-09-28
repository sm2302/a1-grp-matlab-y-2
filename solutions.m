% when code starts running, press on CTRL+C or shift+F5 to stop

% choosing size of the board, n x n board
numRows = input("Enter the number of rows : ");
numColumns = input("Enter the number of columns : ");
% number of alive cells in the first run
numOnes = input("Enter the number of alive cells : ");

% number of alive cells cannot be greater or equal to the board size
if numOnes < (numRows*numColumns)
    % building a board that has empty borders
    % sparse is used if there are numerious zeros in the matrices
    Board = sparse(numRows + 2, numColumns + 2);
    % alive cells are placed randomly on the board
    Board(randperm(numel(Board), numOnes)) = 1;
    % make sure the borders are all zero
    Board(:, 1) = 0;
    Board(:, size(Board, 2)) = 0;
    Board(1, :) = 0;
    Board(size(Board , 1), :) = 0;

    % counting alive neighbouring cells by shifting matrices
    [offset_to_right, offset_to_left, ...
      offset_to_up, offset_to_bottom] = generate_offset_matrices(Board);

    % size of the plots for the diagram
    if(max(numRows, numColumns) < 10)
        MarkerSize = 10;
    elseif (max(numRows, numColumns) < 50)
        MarkerSize = 8;
    elseif (max(numRows, numColumns) < 100)
        MarkerSize = 6;
    elseif (max(numRows, numColumns) < 200)
        MarkerSize = 4;
    else
        MarkerSize = 2;
    end

    % do not have to evaluate the first run because no previous board
    first_run = true;
    % initial board design
    spy(Board, "mpentagram", MarkerSize)
    % time of initial board
    pause(0.5);

    % new board according to the set of rules of Conway's game of life
    while true
        Board = solutions_next_iteration(Board, offset_to_left, offset_to_right, ...
                                          offset_to_up, offset_to_bottom);
        % time of interval between boards
        pause(0.5);
        % program is terminated when the board stays constant
        if (~first_run && isequal(PrevBoard, Board))
        disp("Steady state is reached. The program is terminated")
        break
        end
    % board design for all boards after the intial board
    spy(Board, "mpentagram", MarkerSize)
    PrevBoard = Board;
    first_run = false;
    end

elseif numOnes >= (numRows*numColumns)
    error ('Error. The number of ones chosen are out of range')
end

% nz is the number of non-zero elements in a sparse matrix (alive cells)



% Reference:
%   http://www.mathworks.com/moler/exm/chapters/life.pdf
