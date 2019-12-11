
%% 导入电子表格中的数据
% 用于从以下电子表格导入数据的脚本:
%
%    工作簿: C:\Users\liuji\OneDrive\Documents\University\EEE117\Inverstigation of passive network circuits\ac - 2.0.xlsx
%    工作表: Sheet1
%
% 由 MATLAB 于 2019-12-11 06:13:08 自动生成

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 4);

% 指定工作表和范围
opts.Sheet = "Sheet1";
opts.DataRange = "A1:D11";

% 指定列名称和类型
opts.VariableNames = ["Freq", "Var2", "Var3", "Gain"];
opts.SelectedVariableNames = ["Freq", "Gain"];
opts.VariableTypes = ["double", "char", "char", "double"];

% 指定变量属性
opts = setvaropts(opts, ["Var2", "Var3"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3"], "EmptyFieldRule", "auto");

% 导入数据
ac2 = readtable("C:\Users\liuji\OneDrive\Documents\University\EEE117\Inverstigation of passive network circuits\ac - 2.0.xlsx", opts, "UseExcel", false);


% 清除临时变量
clear opts

%% 处理数据
%初始化数值
r = 100
l = 4.7*(10^-3);
c = 0.01*(10^-6);
freq =1000:0.0001:100000;
%freq = ac2.Freq * 1000;

%初步运算
r2 = r^2;
omg = 2*pi*freq;
reactl = omg*l;
reactc = omg*c;
invreactc = 1./reactc;
react = (reactl-invreactc).^2;

%计算总电感
z = (r2+react).^0.5;
invreactz = 1./z;

%计算增强
Gain = 20*log10(r * invreactz);
[Gmax,Nmax] = max(Gain)
[~,Gresonant] = min(abs(Gain--3))
f0=1/(2*pi*(l*c)^0.5)
% 清除临时变量
clear r l c v r2 omg reactl reactc invreactc react z invreactz;
%% 创建图表
% 创建 figure
figure1 = figure;

%% 使用飘然柔顺
%a = polyfit(ac2.Freq,ac2.Gain,7);
%xx = min(ac2.Freq):0.001:max(ac2.Freq);
%yy = polyval(a,xx);
%plot(xx,yy,'r')

%%
% 创建 axes
axes1 = axes('Parent',figure1,...
    'Position',[0.106710334788938 0.108225108225108 0.775000000000001 0.831168831168831]);
hold(axes1,'on');

% 使用 semilogx 的矩阵输入创建多行
semilogx1 = semilogx(ac2.Freq,ac2.Gain);
semilogx2 = semilogx(freq/1000,Gain);
set(semilogx1,'DisplayName','Measured data','Marker','+');
set(semilogx2,'DisplayName','Theoretical data','Marker','x');

% 创建 ylabel
ylabel({'Gain(dB)',''});

% 创建 xlabel
xlabel('Frequency(KHz)');

% 创建 title
title({'Figure 1:Gain against Frequency in serise LCR cricuit',''});

% 设置Y 范围
ylim(axes1,[-40 0]);
box(axes1,'on');

% 设置其余坐标区属性
set(axes1,'XMinorTick','on','XScale','log','YTick',...
    [-40 -35 -30 -25 -20 -15 -10 -5 0],'YTickLabel',...
    {'-40','-35','-30','-25','-20','-15','-10','-5','0'});

% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.107738099708443 0.856746034016687 0.246428566798568 0.0869047596341086]);
