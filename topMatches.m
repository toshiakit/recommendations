function scores = topMatches(prefs,x1,n,metric)
% topMatches (prefs, x1, n, metric) returns 'n' top matches
% based on the similaity score to x1
% where prefs is a matrix, and x1 its row index.
% metric is function handler for calling score calculation functions
% metric = @sim_distance or @sim_pearson
% return value is a 'score, row index' matrix
    
    % initialize the matrix to hold data
    unsorted=zeros(size(prefs,1)-1,2);
    % initialize index counter
    j=0;
    % loop through rows
    for i=1:size(prefs,1)
        % don't score x1 agaist him/herself
        if i~=x1
            % increment the counter
            j=j+1;
            % get the similarity score
            unsorted(j,1)=metric(prefs,x1,i);
            % get whoes score
            unsorted(j,2)=i;
        end
    end
    
    % sort in descending order
    sorted=-sortrows(-unsorted,1);
    
    % return the first 'n' elements.
    if n<size(sorted,1)
        scores = sorted(1:n,:);
    else
        scores = sorted;
    end
        
    
    
    
    
        
        

