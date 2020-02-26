close all; clear all; clc;
folderMain = 'C:/git/dumbbell-accuracy-at-different-heights\';
folders = dir(fullfile(folderMain,'200224*'));
FLAG = 0;

for jj = 1:length(folders)
    folder1 = fullfile(folderMain,folders(jj).name)
    files = dir(fullfile(folder1,'*.asc'));
    
    for i = 1:length(files)
        fname1 = fullfile(folder1,files(i).name); %get individual file names
        data = dlmread(fname1); %read files
        
        idx = kmeans(data,2);
        dataA = data(idx==1,:);
        dataB = data(idx==2,:);
        
        if (FLAG == 1)
            figure(1);
            scatter3(dataA(:,1),dataA(:,2),dataA(:,3),1)
            hold on;
            scatter3(dataB(:,1),dataB(:,2),dataB(:,3),1)
        end
        
        %fitting sphere
        [aA,bA,cA,RA,centerA,resA,distA] = spherefit(dataA(:,1),dataA(:,2),dataA(:,3));
        [aB,bB,cB,RB,centerB,resB,distB] = spherefit(dataB(:,1),dataB(:,2),dataB(:,3));
        if (FLAG == 1)
            scatter3(aA,bA,cA,1)
            scatter3(aB,bB,cB,1)
        end
        
        
        
        %removing points outside 2*std of the residuals
        
        stdA = std(resA);
        idxresA = abs(resA) < 2*stdA;
        resA2 = resA(idxresA);
        dataA2 = dataA(idxresA,1:3);
        
        stdB = std(resB);
        idxresB = abs(resB) < 2*stdB;
        resB2 = resB(idxresB);
        dataB2 = dataB(idxresB,1:3);
        
        
        %plotting new data set
        if (FLAG == 1)
            figure(2);
            scatter3(dataA(:,1),dataA(:,2),dataA(:,3),1)
            hold on
            scatter3(dataB(:,1),dataB(:,2),dataB(:,3),1)
            scatter3(dataA2(:,1),dataA2(:,2),dataA2(:,3),1)
            scatter3(dataB2(:,1),dataB2(:,2),dataB2(:,3),1)
        end
        
        
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
        distAll{jj,i} = dist(i);
        
        
        %     hold on
        
        
        
    end
    figure(3); hold on;
    %scatter(dist,zheight)
    plot(zheight,dist)
    clear dist; clear zheight;
% break;
end

legend(folders(:).name)