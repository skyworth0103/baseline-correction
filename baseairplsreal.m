real=load('tricyclazole2.mat');
%real=load('Aegirine.mat');
%real=load('Brannerite.mat');
%real=load('RhodamineB.mat');
%real=load('Escherichia_coli.mat');
% t=real.spectrum;
% t=t;
% YY=real.data;
% Yair=YY(1,:);
t=real.input;
t=t';
Y=real.output;
Y=Y';
lambda=10e5;
[Xc,baseair]=airPLS(Y,lambda,2,0.1,0.05,200);
realspectraair=Y-baseair; 
%plot(t,Y,'-k','LineWidth',1);hold on
plot(t,baseair,'--b','LineWidth',1);hold on
% % % plot(t,realspectraair,'-b','LineWidth',1);
%  xlabel('Raman shift(cm^{-1})','fontsize',15)
% ylabel('Intensity','fontsize',15)

