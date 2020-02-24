tic;
close all; clear all; clc;
folder1 = 'C:/git/dumbbell-accuracy-at-different-heights\200210d-Dumbbell';
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
    
    %fitting sphere
    [fitdataA] = spherefit2(dataA(:,1),dataA(:,2),dataA(:,3));
    [fitdataB] = spherefit2(dataB(:,1),dataB(:,2),dataB(:,3));
    scatter3(fitdataA.a,fitdataA.b,fitdataA.c,1)
    scatter3(fitdataB.a,fitdataB.b,fitdataB.c,1)
    
    
    
    %removing points outside 2*std of the residuals
    
    stdA = std(fitdataA.Residuals);
    idxresA = abs(fitdataA.Residuals) < 2*stdA;
    resA2 = fitdataA.Residuals(idxresA);
    dataA2 = dataA(idxresA,1:3); 
    
    stdB = std(fitdataB.Residuals);
    idxresB = abs(fitdataB.Residuals) < 2*stdB;
    resB2 = fitdataB.Residuals(idxresB);
    dataB2 = dataB(idxresB,1:3);
   
    
    %plotting new data set
    figure(2);
    scatter3(dataA(:,1),dataA(:,2),dataA(:,3),1)
        hold on
    scatter3(dataB(:,1),dataB(:,2),dataB(:,3),1)
    scatter3(dataA2(:,1),dataA2(:,2),dataA2(:,3),1)
    scatter3(dataB2(:,1),dataB2(:,2),dataB2(:,3),1)
    
    
    %     [centerA2] = spherefit(dataA2(:,1),dataA2(:,2),dataA2(:,3));
    %     [centerB2] = spherefit(dataB2(:,1),dataB2(:,2),dataB2(:,3));
    %
    [resA2] = spherefit2(dataA2(:,1),dataA2(:,2),dataA2(:,3));
    [resB2] = spherefit2(dataB2(:,1),dataB2(:,2),dataB2(:,3));
    centerA2 = resA2.Center;
    centerB2 = resB2.Center;
    
    %finding distance between the spheres depending on height
    dist(i) = sqrt(sum((centerA2-centerB2).^2));
    zheight(i) = mean(centerA2 + centerB2);
    figure(3);
    %scatter(dist,zheight)
    scatter(zheight,dist)
    
    %     hold on
    
    
end
toc;

