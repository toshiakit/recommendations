function score = sim_pearson(prefs,x1,x2)
% sim_pearson (prefs, x1, x2) calculates similarity score
% where prefs is a matrix, and x1 and x2 its row indices.
% Score is calculated based on Pearson Correlation Coefficient. 
% See here for the actual equation:
% http://davidmlane.com/hyperstat/A51911.html
    
    % get a matrix of shared items
    c1=find(prefs(x1,:)>0);
    c2=find(prefs(x2,:)>0);
    cc=intersect(c1,c2);
    shared_items(1,:)=prefs(x1,cc);
    shared_items(2,:)=prefs(x2,cc);
    
    % get the size of shared_items
    n=size(shared_items,2);
    
    % if no shared items, return 0
    if n== 0
        score = 0;
    else
        % if not, run the algorithm
        x=shared_items(1,:);
        y=shared_items(2,:);
        
        %simple sums Sum(X), Sum(Y)
        sumx = sum(x);
        sumy = sum(y);
        
        %sum of squares Sum(X^2), Sum(X^2)
        sumxSq = sum(x.^2);
        sumySq = sum(y.^2);
        
        %sum of products Sum(X*Y)
        pSum = sum(x.*y);
        
        %numerator of Pearson equation
        num = pSum - (sumx*sumy/n);
        
        %denominator of Pearson equation
        den = sqrt((sumxSq-sumx^2/n)*(sumySq-sumy^2/n));
        
        %caluculate Pearson score
        if den==0
            score = 0;
        else
            score=num/den;
        end
    end