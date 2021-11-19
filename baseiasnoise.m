tic
t=1:1:1000;%∫·÷·»°÷µ
Y=ns2(t)+nb2(t);%º∆À„Y0£¨º¥∆◊Õº
lambda1=10e5;
lambda2=10e-2;
Y=awgn(Y,25,'measured');
Ys=Y;
[Xc,baseasls]=IasLS(Ys,lambda1,lambda2,2,0.001,0.5,100);
simubaseline=nb2(1:1:1000);
diff=baseasls-simubaseline;
diffsquare=diff.^2;
sumdiff=sum(diffsquare);
averdiff=sumdiff/1000;
RMSEIAsLS=sqrt(averdiff);
%  plot(t,Ys,'-k','LineWidth',1);
%   hold on
%  plot(t,nb4(t),'-.b','LineWidth',1);
%  plot(t,baseasls,'--r','LineWidth',1);
% xlabel('Spectral wavelength(wavenumber)','fontsize',15)
% ylabel('Intensity(a.u.)','fontsize',15)
toc