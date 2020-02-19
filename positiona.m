close all; clear all; clc;
folder1 = 'C:/git/dumbbell-accuracy-at-different-heights\200210a-Dumbbell';
files = dir(fullfile(folder1,'*.asc'));

for i = 1:length(files)
    fname1 = fullfile(folder1,files(i).name); %get individual file names
    data = dlmread(fname1); %read files
    
    idx = kmeans(data,2);
    dataA = data(idx==1,:);
    dataB = data(idx==2,:);
    figure(1);
    scatter3(dataA(:,1),dataA(:,2),dataA(:,3),1)
    hold on;
    scatter3(dataB(:,1),dataB(:,2),dataB(:,3),1)
    dataA(i)=dataA
    dataB(i)=dataA
    %fitting sphere
    [aA,bA,cA,RA,centeAr,resA(i),distA] = spherefit(dataA(i)(:,1),dataA(i)(:,2),dataA(i)(:,3));
    [aB,bB,cB,RB,centerB,resB(i),distB] = spherefit(dataB(i)(:,1),dataB(i)(:,2),dataB(i)(:,3));
    scatter3(aA,bA,cA,1)
    scatter3(aB,bB,cB,1)
    title('original data set with fitted sphere')
    hold off
    
    
    %removing points outside 2*std of the residuals
    
    stdA(i) = std(resA(i));
    idxresA(i) = abs(resA) < 2*stdA(i);
    resA2 = resA(idxresA(i));
    dataA2(i) = dataA(i)(idxresA,1:3);
    
    stdB = std(resB);
    idxresB = abs(resB) < 2*stdB;
    resB2 = resB(idxresB);
    dataB2(i) = dataB(i)(idxresB,1:3);
    
    %plotting new data set
    figure(2);
    scatter3(dataA(i)(:,1),dataA(i)(:,2),dataA(i)(:,3),1,'r')
    hold on
    scatter3(dataB(i)(:,1),dataB(i)(:,2),dataB(i)(:,3),1,'r')
    scatter3(dataA2(i)(:,1),dataA2(i)(:,2),dataA2(i)(:,3),1,'c')
    scatter3(dataB2(i)(:,1),dataB2(i)(:,2),dataB2(i)(:,3),1,'c')
    title('Outliers taken out in red')
    hold off
  
    
   
    
end

