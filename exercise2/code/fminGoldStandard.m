function f = fminGoldStandard(p, xy, XYZ, w)

%reassemble P
P = [p(1:4);p(5:8);p(9:12)];

%compute squared geometric error
xy_p = P*XYZ;
xy_p = xy_p ./ (ones(3,1)*xy_p(3,:));
dis = (xy - xy_p).^2;

%compute cost function value
f = sum(sum(dis));
end