tic
t=1:1:1000;%∫·÷·»°÷µ
Y=ns2(t)+nb2(t);%º∆À„Y0£¨º¥∆◊Õº
Y=awgn(Y,25,'measured');
lambda=10e5;
Ys=Y;
[Xc,baseair]=airPLS(Ys,lambda,2,0.1,0.05,200);
simubaseline=nb2(1:1:1000);
diff=baseair-simubaseline;
diffsquare=diff.^2;
sumdiff=sum(diffsquare);
averdiff=sumdiff/1000;
RMSEairpls=sqrt(averdiff);
realspectraair=Ys-baseair;
 %plot(t,realspectraar);
% plot(t,Ys,'-k','LineWidth',1); hold on
%  plot(t,b2(t),'-.b','LineWidth',1);
% plot(t,baseair,'--r','LineWidth',1);
% xlabel('Spectral wavelength(wavenumber)','fontsize',15)
% ylabel('Intensity','fontsize',15)
toc