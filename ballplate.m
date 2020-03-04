% close all;clear all;clc;
folderMain = 'C:/git/dumbbell-accuracy-at-different-heights\';
folders = dir(fullfile(folderMain,'200302-ballplate'));
for i = 1:length(folders);
    folders1 = fullfile(folderMain,folders(1).name)
    files = dir(folders1,'*.asc'));
end
    for ii = 1 : length(files)
        fname1 = fullfile(folders1,files(ii).name);
        data = dlmread(fname1);
        mat = [-109.4000  -30.8200  328.9000
        -53.3200  -21.2900  331.7000
        -7.1800  -14.4300  326.8000
        36.6000   -5.3290  327.6000
        88.0300    2.2360  329.7000
        138.5000    12.257290  281.000
        138.3000   10.63  231.0000
        141.8000    9.4250  228.6000
        141.2000    9.7750  173.5000
        139.6000    9.3960  126.8000
        138.3000    9.4480   71.6600
        92.7800    0.8913   76.0300
        40.9800   -7.0720   74.7400
        -8.2680  -15.2100   74.3700
        -57.5700  -23.2600   76.4700
        -109.9000  -31.3600   76.4300
        -107.9000  -31.1200  128.8000
        -108.5000  -31.0600  175.4000
        -108.7000  -30.8800  229.8000
        -105.8000  -30.3900  281.1000
        17.2300  -10.8200  202.1000]
    
        idx = kmeans(data,21,'start',mat)
        dataA = data(idx == 1,:); dataB = data(idx == 2,:); dataC = data(idx == 3,:);
        dataD = data(idx == 4,:); dataE = data(idx == 5,:); dataF = data(idx == 6,:);
        dataG = data(idx == 7,:); dataH = data(idx == 7,:); dataI = data(idx == 8,:);
        dataJ = data(idx == 9,:); dataK = data(idx == 10,:); dataL = data(idx == 11,:);
        dataM = data(idx == 12,:); dataN = data(idx == 13,:); dataO = data(idx == 14,:);
        dataP = data(idx == 15,:); dataQ = data(idx == 16,:); dataR = data(idx == 17,:);
        dataS = data(idx == 18,:); dataT = data(idx == 19,:); dataU = data(idx == 20,:);
        
        figure(1);
        scatter3(dataA(:,1),dataA(:,2),dataA(:,3),1)
        hold on
        pause
        scatter3(dataB(:,1),dataB(:,2),dataB(:,3),1)
        pause
        scatter3(dataC(:,1),dataC(:,2),dataC(:,3),1)
        pause
        scatter3(dataD(:,1),dataD(:,2),dataD(:,3),1)
        pause
        scatter3(dataE(:,1),dataE(:,2),dataE(:,3),1)
        pause
        scatter3(dataF(:,1),dataF(:,2),dataF(:,3),1)
        pause
        scatter3(dataG(:,1),dataG(:,2),dataG(:,3),1)
        pause
        scatter3(dataH(:,1),dataH(:,2),dataH(:,3),1)
        pause
        scatter3(dataI(:,1),dataI(:,2),dataI(:,3),1)
        pause
        scatter3(dataJ(:,1),dataJ(:,2),dataJ(:,3),1)
        pause
        scatter3(dataK(:,1),dataK(:,2),dataK(:,3),1)
        pause
        scatter3(dataL(:,1),dataL(:,2),dataL(:,3),1)
        pause
        scatter3(dataM(:,1),dataM(:,2),dataM(:,3),1)
        pause
        scatter3(dataN(:,1),dataN(:,2),dataN(:,3),1)
        pause
        scatter3(dataO(:,1),dataO(:,2),dataO(:,3),1)
        pause
        scatter3(dataP(:,1),dataP(:,2),dataP(:,3),1)
        pause
        scatter3(dataQ(:,1),dataQ(:,2),dataQ(:,3),1)
        pause
        scatter3(dataR(:,1),dataR(:,2),dataR(:,3),1)
        pause
        scatter3(dataS(:,1),dataS(:,2),dataS(:,3),1)
        pause
        scatter3(dataT(:,1),dataT(:,2),dataT(:,3),1)
        pause
        scatter3(dataU(:,1),dataU(:,2),dataU(:,3),1)
     disp('all clusters plotted')
       break
       
    end

