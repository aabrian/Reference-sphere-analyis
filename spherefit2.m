function [result] = spherefit2(x,y,z)
% Getting A matrix
e = -2.*x;
d = -2.*y;
f = -2.*z;
zz = ones(length(x),1);
A = [e d f zz];
B = zeros(length(x),1);
for i = 1:length(x);
    B(i,1) = -(x(i).^2+y(i).^2+z(i).^2);
end
X = A\B;
center = [X(1) X(2) X(3)];
g = X(1); h = X(2); k = X(3); j = X(4);
R = sqrt(g.^2+h.^2+k.^2-j);
[q,r,s] = sphere(99);
q2 = R*q(:); r2 = R*r(:); s2 = R*s(:);
q3 = q2+X(1); r3 = r2+X(2); s3 = s2+X(3);
a = q3;
b = r3;
c = s3;
R = R;
distance = zeros(length(x));
for i = 1 : length(x);
    distance(i) = sqrt((x(i)-center(1)).^2+(y(i)-center(2)).^2+(z(i)-center(3)).^2);
end
dist = distance';
resid = distance-R;
res = resid';
result.a = a;
result.b = b;
result.c = c;
result.Center = center;
result.Radius = R;
result.Residuals = res;

end

