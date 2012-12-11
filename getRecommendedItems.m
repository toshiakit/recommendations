function rankings = getRecommendedItems(prefs,itemMatch,x1)
% getRecommendations (prefs, itemMatch, user) returns recommendations
% for x1 by using a weighted average of similarity scores of the 
% similar items in the item similarity dataset,
% where prefs is a matrix, x1 its row index, and itemMatch the cell 
% array of item similarity dataset derived from prefs.
% return value is a 'predicted score, row index' matrix
    
    % get all the ratings for x1 as a row vector
    userRatings=prefs(x1,:);
    
    % find the indices of rated items
    rated=find(userRatings>0);
    % find the indices of unrated items
    unrated=find(userRatings<=0);
    
    % initialize the matrix to hold sim scores
    sims=zeros(size(rated,2), size(unrated,2));
    
    % loop over the items rated by x1
    for i=1:size(rated,2)
        % get the index of rated item
        x=rated(1,i);
        % loop over the items not rated by x1
        for j=1:size(unrated,2)
            % get the indices of items in itemMatch for x
            itemIndices=itemMatch{x,1}(:,2);
            % get the index of the unrated item
            y=find(itemIndices==unrated(1,j),1);
            if ~isempty(y)
                % get the sim score between the rated and unrated items
                sims(i,j)=itemMatch{x,1}(y,1);
            end
        end
    end
    
    % get the ratings and make the matrix dimension equal to sims
    ratings=repmat(userRatings(rated)',1,size(sims,2));
    
    % obtain scores by multiplying sims by ratings
    scores=sims.*ratings;
    
    % Divide each total score by total weighting to get an average
    unsorted=zeros(2,size(scores,2));
    for j=1:size(unrated,2)
        if sum(sims(:,j))~=0
            unsorted(1,j)=sum(scores(:,j))./sum(sims(:,j));
        else
            unsorted(1,j)=0;
        end
    end
    unsorted(2,:)=unrated;
    
    % sort in descending order
    rankings=-sortrows(-unsorted',1);
    
    % delete unnecessary rows
    [r,c]= find(rankings(:,1)==0);
    rankings(r,:)=[];
        
            
                
                
                
              
      
   