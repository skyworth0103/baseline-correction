t=1:1:1000;%����ȡֵ
spec1=4*exp(-(t-60).^2/200)+10*exp(-(t-100).^2/200)+10*exp(-(t-150).^2/200)+6*exp(-(t-240).^2/200)+18*exp(-(t-300).^2/300)+7*exp(-(t-450).^2/250)+10*exp(-(t-500).^2/250)+9*exp(-(t-610).^2/400)+10*exp(-(t-840).^2/200)+4*exp(-(t-880).^2/250)+8*exp(-(t-950).^2/350); 
base1=1e-3*t+20*exp(-(t-150).^2/1e6/2)+30*exp(-(t-650).^2/1e4/12);
Y=spec1+base1;%����Y0������ͼ
lambda=10e4;
Y=awgn(Y,22,'measured');
Ys=Y;
[Xc,baseair]=airPLS(Ys,lambda,2,0.01,0.5,40);
simubaseline=base1(1:1:1000);
diff=baseair-simubaseline;
diffsquare=diff.^2;
sumdiff=sum(diffsquare);
averdiff=sumdiff/1000;
RMSEairpls=sqrt(averdiff);
% plot(t,Ys,'-k','LineWidth',1);
% hold on
% plot(t,nb4(t),'-.b','LineWidth',1);
plot(t,baseair,'--b','LineWidth',2);
% xlabel('Spectral wavelength(wavenumber)','fontsize',15)
% ylabel('Intensity','fontsize',15)
