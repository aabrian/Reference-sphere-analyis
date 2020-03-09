clc; clear all; close all;
folderMain = 'C:\git\dumbbell-accuracy-at-different-heights'
folders = dir(fullfile(folderMain,'200304*'))
folder1 = fullfile(folderMain,folders.name)
files = dir(fullfile(folder1,'*.asc'))
for i = 1 : length(files);
    fname = fullfile(folder1,files(i).name);
    data1 = dlmread(fname);
    
    
    centerscol = [-106.3 -30.69 332.5; 140.6 9.799 330.7; 17.4 -10.83 205.1; ...
        -106.5 -31.33 78.8; 141.8 8.783 78.89];
    
    NROI = 5;
    
    for ii = 1:NROI %finding center and Radius of each ROI
        ROIdata = getROI(data1,centerscol(ii,:),20);
        
        sphereROI = spherefit2(ROIdata(:,1),ROIdata(:,2),ROIdata(:,3));
        centerROI(ii,1) = sphereROI.Center(1);  centerROI(ii,2) = sphereROI.Center(2);  centerROI(ii,3) = sphereROI.Center(3);
        diameterROI(ii) = sphereROI.Radius*2;
    end
    
    %distance between the two spheres
  centerROI(1,:)
  centerROI(2,:)
    %angle
    
    angDegree(i) = atand((centerROI(1,2)-centerROI(2,2)) / (centerROI(1,1)-centerROI(2,1)))
    
 
end