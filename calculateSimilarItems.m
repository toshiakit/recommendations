function result = calculateSimilarItems(prefs,n,metric)
% Create a matrix of items showing which other items they are similar to.

% Convert the preferece matrix from critic-centric to item-centric
itemPrefs=prefs';

% Initialize cell array to hold result
result=cell(size(itemPrefs,1),1);

% Initlialize the counter
c=0;
% go through each item in the rows
for i=1:size(itemPrefs,1)
    % Status updates for large datasets at every 100th item
    c=c+1;
    if mod(c,100)==0
        head = 'Procesing... item ';
        delimiter = ' / ';
        status = [head int2str(c) delimiter int2str(size(itemPrefs,1))];
        disp(status)
    end
    % Find the most similar items to this one
    scores=topMatches(itemPrefs, i, n, metric);
    result{i,1}=scores;
end


