clc; close all; clear all;
pwd
folderMain = 'C:\git\dumbbell-accuracy-at-different-heights';
folders = dir(fullfile(folderMain,'200304*'));
folder1 = fullfile(folderMain,folders.name);
files = dir(fullfile(folder1,'*.asc'));
%Read the file
flag = 0;
for i = 1:length(files)
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
        NROI = 5; %number of ROIs
        %finding ROI
        CenterROI = zeros(length(NROI),3);
        for iii = 1:5 %finding center and Radius of each ROI
            ROIdata = getROI(dataA,centerscol(iii),20);
            
            [sphereROI] = spherefit2(ROIdata(:,1),ROIdata(:,2),ROIdata(:,3));
            CenterROI(iii,1) = sphereROI.Center(1);  CenterROI(iii,2) = sphereROI.Center(2);  CenterROI(iii,3) = sphereROI.Center(3);
            diameterROI(iii) = sphereROI.Radius*2;
        end
        j = 1;
        h = 1;
        count = 1;
        for jj = 1:NROI-1
            j = jj;
            while j < NROI
                dist1(count) = rssq(CenterROI(jj)-CenterROI(h+1))
                j = j+1;
                h = j+1;
                count = count + 1;
            end
            h = jj+1;
        end
    end
    %     disp(files(i).name)
    %     pause
    
    
    
    
    
    
    
end
