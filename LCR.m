
%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: C:\Users\liuji\OneDrive\Documents\University\EEE117\Inverstigation of passive network circuits\ac - 2.0.xlsx
%    ������: Sheet1
%
% �� MATLAB �� 2019-12-11 06:13:08 �Զ�����

%% ���õ���ѡ���������
opts = spreadsheetImportOptions("NumVariables", 4);

% ָ��������ͷ�Χ
opts.Sheet = "Sheet1";
opts.DataRange = "A1:D11";

% ָ�������ƺ�����
opts.VariableNames = ["Freq", "Var2", "Var3", "Gain"];
opts.SelectedVariableNames = ["Freq", "Gain"];
opts.VariableTypes = ["double", "char", "char", "double"];

% ָ����������
opts = setvaropts(opts, ["Var2", "Var3"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3"], "EmptyFieldRule", "auto");

% ��������
ac2 = readtable("C:\Users\liuji\OneDrive\Documents\University\EEE117\Inverstigation of passive network circuits\ac - 2.0.xlsx", opts, "UseExcel", false);


% �����ʱ����
clear opts

%% ��������
%��ʼ����ֵ
r = 100
l = 4.7*(10^-3);
c = 0.01*(10^-6);
freq =1000:0.0001:100000;
%freq = ac2.Freq * 1000;

%��������
r2 = r^2;
omg = 2*pi*freq;
reactl = omg*l;
reactc = omg*c;
invreactc = 1./reactc;
react = (reactl-invreactc).^2;

%�����ܵ��
z = (r2+react).^0.5;
invreactz = 1./z;

%������ǿ
Gain = 20*log10(r * invreactz);
[Gmax,Nmax] = max(Gain)
[~,Gresonant] = min(abs(Gain--3))
f0=1/(2*pi*(l*c)^0.5)
% �����ʱ����
clear r l c v r2 omg reactl reactc invreactc react z invreactz;
%% ����ͼ��
% ���� figure
figure1 = figure;

%% ʹ��ƮȻ��˳
%a = polyfit(ac2.Freq,ac2.Gain,7);
%xx = min(ac2.Freq):0.001:max(ac2.Freq);
%yy = polyval(a,xx);
%plot(xx,yy,'r')

%%
% ���� axes
axes1 = axes('Parent',figure1,...
    'Position',[0.106710334788938 0.108225108225108 0.775000000000001 0.831168831168831]);
hold(axes1,'on');

% ʹ�� semilogx �ľ������봴������
semilogx1 = semilogx(ac2.Freq,ac2.Gain);
semilogx2 = semilogx(freq/1000,Gain);
set(semilogx1,'DisplayName','Measured data','Marker','+');
set(semilogx2,'DisplayName','Theoretical data','Marker','x');

% ���� ylabel
ylabel({'Gain(dB)',''});

% ���� xlabel
xlabel('Frequency(KHz)');

% ���� title
title({'Figure 1:Gain against Frequency in serise LCR cricuit',''});

% ����Y ��Χ
ylim(axes1,[-40 0]);
box(axes1,'on');

% ������������������
set(axes1,'XMinorTick','on','XScale','log','YTick',...
    [-40 -35 -30 -25 -20 -15 -10 -5 0],'YTickLabel',...
    {'-40','-35','-30','-25','-20','-15','-10','-5','0'});

% ���� legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.107738099708443 0.856746034016687 0.246428566798568 0.0869047596341086]);
