% generating offset matrices
% shifting of matrices
function [offset_to_right, offset_to_left, ...
           offset_to_up, offset_to_bottom] = generate_offset_matrices(Board)

  rowNum = size(Board, 1);
  colNum = size(Board, 2);

  offset_to_right = [1 1:colNum-1];
  offset_to_left = [2:colNum colNum];
  offset_to_up = [2:rowNum rowNum];
  offset_to_bottom = [1 1:rowNum-1];

end
