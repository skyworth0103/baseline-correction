tic
real=load('tricyclazole2.mat');
%real=load('Aegirine.mat');
%real=load('Brannerite.mat');
%real=load('RhodamineB.mat');
%real=load('Escherichia_coli.mat');
t=real.input;
t=t';
Y=real.output;
Y=Y';
lambda1=10e5;
lambda2=10e-2;
Ys=Y;
[Xc,baseasls]=IasLS(Ys,lambda1,lambda2,2,0.05,0.5,100);
%  plot(t,Ys,'-k','LineWidth',1);
% hold on;
plot(t,baseasls,':c','LineWidth',1.5);
% xlabel('Spectral wavelength(wavenumber)','fontsize',15)
% ylabel('Intensity','fontsize',15)
toc