tic
err=4e0;
t=1:1:1000;%横轴取值
N=length(t);%横轴取N个点
gen_max=100;%最大遗传代数
F=0.3;%缩放因子
bestbase=ones(1,N);%初始化
spec1=4*exp(-(t-60).^2/200)+10*exp(-(t-100).^2/200)+10*exp(-(t-150).^2/200)+6*exp(-(t-240).^2/200)+18*exp(-(t-300).^2/300)+7*exp(-(t-450).^2/250)+10*exp(-(t-500).^2/250)+9*exp(-(t-610).^2/400)+10*exp(-(t-840).^2/200)+4*exp(-(t-880).^2/250)+8*exp(-(t-950).^2/350); 
base1=1e-3*t+20*exp(-(t-150).^2/1e6/2)+30*exp(-(t-650).^2/1e4/12);
Y0=spec1+base1;%计算Y0，即谱图
Y0=awgn(Y0,22,'measured');
Ys=Y0;%设置初始Ys为Y0
pop_best=ones(1,N);%初始化最优个体，随机的
Y=zeros(size(1));%初始化Y，用于存储种群函数;
pop_m=zeros(1,N);
for gen=1:gen_max
        tt=t(bestbase(:)==1);
        Yt=Y0(tt);
        Y=cubicspsmooth(tt,Yt,10e-7,t);
     e1=sum(abs(Ys-Y))/N;
     e2=sum(bestbase(:));
     fitness1=(e1*e2)/(e1+e2);
        D=min(round(F*sum(bestbase)),N);
         muD=ceil(rand(1,D)*N);
        pop_m=bestbase;  
        for j=1:D
            pop_m(muD(j))=0;
        end    
    pop_m(:,1)=1;pop_m(:,end-1:end)=1;%避免端部偏移
    bestbase=pop_m;  
        tt=t(bestbase(:)==1);
        Yt=Y0(tt);
        Y=cubicspsmooth(tt,Yt,10e-7,t);
       for j=1:N
            if Y(j)+err<Ys(j)
                Ys(j)=Y(j);
            end
        end
        for j=1:N
            if Ys(j)<Y0(j)
                bestbase(j)=0;
            end
        end
        for i=1:N
        if Ys(i)==Y0(i)
            bestbase(i)=1;
        end
        end 
       Ys(1:12)=Y0(1:12);
       Ys(end-10:end)=Y0(end-10:end);
    e1=sum(abs(Ys-Y))/N;
    e2=sum(bestbase(:));
     fitness2=(e1*e2)/(e1+e2);
     if gen>=2&&(abs(fitness1-fitness2)<0.0005)
        break;
     end 
    bestbase(1:10)=1;bestbase(end-10:end)=1;
end
pop_best=cubicspsmooth(t(bestbase(1,:)==1),Y0(bestbase(1,:)==1),10e-6,t);
%yintensity=s2.evalAt(knots(19:78));
realspectra=Y0-pop_best;
simubaseline=base1;
diff=pop_best-simubaseline;
diffsquare=diff.^2;
sumdiff=sum(diffsquare);
averdiff=sumdiff/1000;
RMSE=sqrt(averdiff);

%以下为作图部分
 plot(t,Y0,'-k','LineWidth',1);hold on
 plot(t,pop_best,'-r','LineWidth',1);hold on;
 %plot(t,simubaseline,'-g','LineWidth',1);hold on;
 %plot(t,realspectra,'-b','LineWidth',1);
 axis([0 1000 0 80])
 xlabel('Raman shift(cm^{-1})','fontsize',15)
 ylabel('Intensity(a.u.)','fontsize',15)
toc
