function score = sim_distance(prefs,x1,x2)
% sim_distance (prefs, x1, x2) calculates similarity score
% where prefs is a matrix, and x1 and x2 its row indices.
% Score is calculated based on inverted Euclidean distance
% so the higher score, the more silimar
% Euclidean distance = 1+sqrt(sum((A-B).^2));
%                or
% Euclidean Distance = 1+norm(A-B);
% where A and B represents reviews of identical movies by two
% different reviewers x1 and x2. 
    
    % get a matrix of shared items
    c1=find(prefs(x1,:)>0);
    c2=find(prefs(x2,:)>0);
    cc=intersect(c1,c2);
    shared_items(1,:)=prefs(x1,cc);
    shared_items(2,:)=prefs(x2,cc);
    
    % if shared_item is empty, return 0
    if size(shared_items,2)== 0
        score = 0;
    else
        % otherwise run the algorithm
        % euclidean_distance = sqrt(sum((shared_items(1,:)-shared_items(2,:)).^2));
        euclidean_distance = norm(shared_items(1,:)- shared_items(2,:));
        
        % invert Euclidean distance so that it scale from 0 to 1
        % and the more similar, higher the score
        score = 1/(1+euclidean_distance);
        
    end
    
    
	
