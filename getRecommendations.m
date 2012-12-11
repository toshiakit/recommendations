function rankings = getRecommendations(prefs,x1,metric)
% getRecommendations (prefs, x1, metric) returns recommendations for
% user x1 by using a weighted average of every other user's rankings,
% where prefs is a matrix, and x1 its row index.
% metric is function handler for calling score calculation functions
% metric = @sim_distance or @sim_pearson
% return value is a 'predicted score, column index' matrix
  
    sim=zeros(size(prefs,1),1);
    % go through each row
    for i=1:size(prefs,1)
        % don't compare to x1 itself
        if i~=x1
            % get similarity score between x1 and i
            sim(i,1)=metric(prefs,x1,i);
        else
            sim(i,1)=0;
        end
    end
    
    % if sim score >0 
    r=find(sim(:,1)>0);
    % and if it is not rated by User x1
    c=find(prefs(x1,:)==0);
    
    % reformat the matrix holding sim scores
    sims=repmat(sim(r,1),1,size(c,2));
    sims(find(prefs(r,c)<=0))=0;
    
    % then get ratings x sim scores
    unrated=prefs(r,c).*sims;
    
    % normalize the weighted scores
    unsorted=zeros(2,size(unrated,2));
    for j=1:size(unrated,2)
        if sum(sims(:,j))~=0
            unsorted(1,j)=sum(unrated(:,j))./sum(sims(:,j));
        else
            unsorted(1,j)=0;
        end
    end
    unsorted(2,:)=c;

    % sort in descending order
    rankings=-sortrows(-unsorted',1);
    
    % delete unnecessary rows
    [r,c]= find(rankings(:,1)==0);
    rankings(r,:)=[];
    
    
                
    
              
                    
                    
                    
                    
    
    
    
        
        

