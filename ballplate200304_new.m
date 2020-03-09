clc; close all; clear all;
folderMain = 'C:\git\dumbbell-accuracy-at-different-heights';
folders = dir(fullfile(folderMain,'200304*'));
folder1 = fullfile(folderMain,folders.name);
files = dir(fullfile(folder1,'*.asc'));
%Read the file
flag = 0;
for i = 1:length(files) %for each file cluster data into N clusters using rotation matrix
    fname1 = fullfile(folder1,files(i).name);
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
        if (flag == 1)
            figure(1); view(0,0);
            plot3(dataA(:,1),dataA(:,2), dataA(:,3),'.'); hold on;
            
            %Obtain the centroid and display the number above the sphere.
            cent = mean(dataA);
            text(cent(1),cent(2),cent(3)+20,num2str(ii));
            pause(.1);
        end
        %approximate centers for corner and center spheres
        centerscol = [-106.3 -30.69 332.5; 140.6 9.799 330.7; 17.4 -10.83 205.1; ...
            -106.5 -31.33 78.8; 141.8 8.783 78.89];
        centersrow = centerscol';
        
        
    end
    NROI = 5; %number of ROIs
    %finding ROI
    for iii = 1:NROI %finding center and Radius of each ROI
        ROIdata = getROI(data1,centerscol(iii,:),20);
        
        sphereROI = spherefit2(ROIdata(:,1),ROIdata(:,2),ROIdata(:,3));
        centerROI(iii,1) = sphereROI.Center(1);  centerROI(iii,2) = sphereROI.Center(2);  centerROI(iii,3) = sphereROI.Center(3);
        diameterROI(iii) = sphereROI.Radius*2;
        
        
    end
    count = 1;
    for jj = 1:NROI
        j = jj;
        h = jj;
        while j < NROI
            dist(count) = rssq(centerROI(jj,:) - centerROI(h+1,:));
            j = j+1;
            h = j;
            sphLegend(count,:) = strcat(char(64+jj),char(64+h+1)); %To get a label of the spheres
            count = count + 1;
        end
    end
    scatter3(data1(:,1),data1(:,2),data1(:,3),.7);
    hold on
    for q = 1: NROI
        scatter3(centerROI(q,1),centerROI(q,2),centerROI(q,3),3,'filled');
    end
    hold off
%     dist1(i) = dist(1);
%     dist2(i) = dist(2);
%     dist3(i) = dist(3);
%     dist4(i) = dist(4);
%     dist5(i) = dist(5);
%     dist6(i) = dist(6);
%     dist7(i) = dist(7);
%     dist8(i) = dist(8);
%     dist9(i) = dist(9);
%     dist10(i) = dist(10);
distAll(i,:) = dist;
end

angleint = [8 16 24 32 40 48 56 64 72 80 -56 -48 -40 -32 -24 -16 -8 0];
meanDist = mean(distAll);
errDist = bsxfun(@minus,distAll,meanDist);

%Sorted errors by the angle (low to high)
[val,idx] = sort(angleint);
ang2 = angleint(idx);
errDist2 = errDist(idx,:);

figure(2); clf; plot(ang2,errDist2(:,1:5),'LineWidth',2)
figure(2); hold on; ; plot(ang2,errDist2(:,6:end),'-.','LineWidth',2)



grid on; 
xlabel('Angle in degrees');
ylabel('Error in distance, mm')
legend(sphLegend);

figure(3); errorbar(ang2,mean(errDist2'),std(errDist2'));
grid on; 
xlabel('Angle in degrees');
ylabel('Error in distance, mm')
xlim([-70 85]);

% figure(1)
% scatter(angleint,dist1)
% figure(2)
% scatter(angleint,dist2)
% figure(3)
% scatter(angleint,dist3)
% figure(4)
% scatter(angleint,dist4)
% figure(5)
% scatter(angleint,dist5)
% figure(6)
% scatter(angleint,dist6)
% figure(7)
% scatter(angleint,dist7)
% figure(8)
% scatter(angleint,dist8)
% figure(9)
% scatter(angleint,dist9)
% figure(10)
% scatter(angleint,dist10)