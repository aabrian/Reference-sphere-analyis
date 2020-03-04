function ROIdata = getROI(data1,center1,dist1)
%Truncate datasets based on a center and the distance of points from the center
distA = rssq(bsxfun(@minus,data1,center1),2);
idxA = distA<dist1;
ROIdata = data1(idxA,:);
% distI = data2(~idxA,:);
end
