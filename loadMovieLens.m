function [mldata, mlmovies, mlrated] = loadMovieLens(path)
% MovieLens dataset was developed by the GroupLens project at the 
% University of Minnesota and it can be downloaded from 
% http://www.grouplens.org/node/12
% There are two dataset and here we use the 100,000 dataset. 

% load data from 'u.data', where the first column is user id, the second
% movie id, the third rating, and the fourth the timestamp. 

% filepath to u.data
filepath=[path '/u.data'];

% data is in tab-delimited format
data = dlmread(filepath, '\t');
% find how many users are in the dataset
maxUsers=max(data(:,1));
% find how many movies are in the dataset
maxMovies=max(data(:,2));
% sort it by user id
sorted=sortrows(data,1);
% create the zero array to hold data
mldata=zeros(maxUsers,maxMovies);

% go through all the rows
for i=1:size(sorted,1)
    user=sorted(i,1);
    movie=sorted(i,2);
    rating=sorted(i,3);
    mldata(user,movie)=rating;
    mlrated(user,movie)=1;
end
mlrated = logical(mlrated);

% load data from 'u.item', where the first column is the movie id and the
% second is the movie titles, delimited by '|'. 
format = '%d %s %s %s %s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d';
filepath=[path '/u.item'];
fid = fopen(filepath);
file = textscan(fid, format, 'delimiter', '|');
fclose(fid);

% initialize the cell matrix to hold data
mlmovies=cell(1,size(file{1,1},1));

% store the movie tiles only based on the movie id
for i=1:size(file{1,1},1);
    movieid=file{1,1}(i,1);
    mlmovies{1,i}=file{1,2}{movieid,1};
end

