% load('matlab.mat', 'x')
lenX = length(x);
tt = lenX / 256;    % 估计使用的采样率为256Hz
ts = linspace(0, tt, lenX);
xt = x / 1024;      % Arduino采样位深为10 bit即1024位
xt = xt - 0.37;     % 由于没有查找到关于AD8232输出直流偏置的信息, 因此只能根据波形估计其基线位置
xt = xt / 1100;     % 原模块采用AD8232心脏监护仪配置，系统总增益为1100(见说明书)
plot(ts, xt)
t_x = [ts; xt];
txt = [];
for ii = 1 : lenX
    txt = [txt, num2str(t_x(1, ii)), ', ', num2str(t_x(2, ii)), '; ']; %#ok<AGROW>
end
fid = fopen('PWL_Source.txt', 'wt');
fprintf(fid, txt);
fclose(fid);