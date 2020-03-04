clc; close all; clear all;
pwd
folderMain = 'C:\git\dumbbell-accuracy-at-different-heights';
folders = dir(fullfile(folderMain,'200302*'))
folder1 = fullfile(folderMain,folders.name)
files = dir(fullfile(folder1,'*.asc'))
%Read the file
for i = 1:length(files);
fname1 = fullfile(folder1,files(i).name)
data1 = dlmread(fname1);

%Number of spheres in the file
N = 21;

%Perform a principal component analysis and find the rotation matrix
rotMat = pca(data1);

%Rotate the data using the rotation matrix
data2 = data1*rotMat;

%Now, the 3rd dimension of the rotated matrix has minimum variation, so
%ignore it for this operation
data3 = data2(:,1:2);

%Perform kmeans clustering. 
idx = kmeans(data3,N,'Replicates',15,'MaxIter',5000);
%idx = kmeans(data3,N);

for ii = 1:N
    
    %Obtain the individual dataset, supposedly for each sphere
    dataA = data1(idx==ii,:);
    
    %Plot the data
    figure(1); view(0,0);
    plot3(dataA(:,1),dataA(:,2), dataA(:,3),'.'); hold on; 
    
    %Obtain the centroid and display the number above the sphere. 
    cent = mean(dataA);
    text(cent(1),cent(2),cent(3)+20,num2str(ii));
    pause(.1);
end
pause;clf;
end