clc;clear all;
load('SPH.txt');
figure(1);
[a,b,c,R,center,res,dist] = spherefit(SPH(:,1),SPH(:,2),SPH(:,3));
figure(1);
scatter3(SPH(:,1),SPH(:,2),SPH(:,3),1)
hold on
%scatter3(center(1),center(2),center(3))
%scatter3(a,b,c,1);

std1 = std(res)
idx = abs(res) < 3*std1;
res2 = res(idx);
a2 = SPH(idx,1);
b2 = SPH(idx,2);
c2 = SPH(idx,3);
scatter3(a2,b2,c2,1)

% res2 = res;
% for ii = 1:length(idx)
%     if idx(ii) == 0
%         res2(ii) = [];
%      %   disp('Excluded')
%     end
%     length(idx)
%     length(res2)
%     
%     
%     pause(1);
% end


figure(2);
plot(res)
hold on
plot(res2,'r');
upLim  = res*0 + 3*std1;
loLim  = res*0 - 3*std1;
meanVal = res*0 + mean(res);
plot(upLim); plot(loLim); plot(meanVal,'k');

std2 = std(res2);
idx = abs(res2)<3*std2;
res3 = res2(idx);
figure(3);
plot(res2)
hold on
plot(res3,'r')
uplim = res*0 + 3*std2;
loLim  = res*0 - 3*std2;
meanVal = res*0 + mean(res2);
plot(upLim); plot(loLim); plot(meanVal,'k');

std3 = std(res3);
idx = abs(res3)<3*std3;
res4 = res3(idx);
figure(4);
plot(res3)
hold on
plot(res4,'r')
uplim = res*0 + 3*std3;
loLim  = res*0 - 3*std3;
meanVal = res*0 + mean(res3);
plot(upLim); plot(loLim); plot(meanVal,'k');

std4 = std(res4);
idx = abs(res4)<3*std4;
res5 = res4(idx);
figure(5);
plot(res4)
hold on
plot(res5,'r')
uplim = res*0 + 3*std4;
loLim  = res*0 - 3*std4;
meanVal = res*0 + mean(res4);
plot(upLim); plot(loLim); plot(meanVal,'k');

std5 = std(res5);
idx = abs(res5)<3*std5;
res6 = res5(idx);
figure(6);
plot(res5)
hold on
plot(res6,'r')
uplim = res*0 + 3*std5;
loLim  = res*0 - 3*std5;
meanVal = res*0 + mean(res5);
plot(upLim); plot(loLim); plot(meanVal,'k');