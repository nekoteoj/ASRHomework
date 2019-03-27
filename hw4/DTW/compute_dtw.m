function [distance] = compute_dtw(template,test)
    %Given input template and test
    %Compute the dtw distance
    N = length(template);
    M = length(test);
    dtw = zeros(length(template), length(test), "double");
    for i = 1:length(template)
      for j = 1:length(test)
        dtw(i, j) = inf;
      end
    end
    dtw(1, 1) = 0;
    for i = 1:length(template)
      for j = 1:length(test)
        if (abs(i - j) > 50 || i/j > 2 || i/j < 0.5 || j > 0.5*(i - N) + M)
          continue
        end
        % dist = norm(template(:, i) - test(:, j));
        dist = sqrt(sum((template(:, i) - test(:, j)).^2));
        if (i-1 >= 1 && j-1 >= 1)
          dtw(i, j) = min(dtw(i, j), dtw(i-1, j-1) + dist);
        end
        if (i-2 >= 1 && j-1 >= 1)
          dtw(i, j) = min(dtw(i, j), dtw(i-2, j-1) + 2*dist);
        end
        if (i-1 >= 1 && j-2 >= 1)
          dtw(i, j) = min(dtw(i, j), dtw(i-1, j-2) + dist);
        end
        if (i == 1 && j == 1)
          dtw(i, j) = dist;
        end
      end
    end
    %dtw(N, :)
    distance = min(dtw(N, :));
end
