tic
err=0.8e2;
%real=load('Aegirine.mat');
real=load('tricyclazole2.mat');
%real=load('Brannerite.mat');
%real=load('RhodamineB.mat');
%real=load('Escherichia_coli.mat');
 t=real.input;
 t=t';
 Y0=real.output;
 Y0=Y0';
 
N=length(t);%横轴取N个点
gen_max=100;%最大遗传代数
F=0.1;%缩放因子
bestbase=ones(1,N);%初始化
Ys=Y0;%设置初始Ys为Y0
pop_best=ones(1,N);%初始化最优个体，随机的
Y=zeros(size(1));%初始化Y，用于存储种群函数;
psmooth=10e-6;%Psplines平滑系数设置
pop_m=zeros(1,N);

for gen=1:gen_max
      tt=t(bestbase(:)==1);
        Yt=Y0(bestbase(:)==1);
        Y=cubicspsmooth(tt,Yt,psmooth,t);
     e1=sum(abs(Ys-Y))/N;
     e2=sum(bestbase(:));
     fitness1=(e1*e2)/(e1+e2);

        D=min(round(F*sum(bestbase)),N);
         muD=ceil(rand(1,D)*N);
        pop_m=bestbase;  
        for j=1:D
                  pop_m(muD(j))=0;
        end    
 
    pop_m(:,1:5)=1;pop_m(:,end-5:end)=1;%避免端部偏移
    bestbase=pop_m;  
       tt=t(bestbase(:)==1);
        Yt=Y0(bestbase(:)==1);
        Y=cubicspsmooth(tt,Yt,psmooth,t);
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
pop_best=cubicspsmooth(t(bestbase(1,:)==1),Y0(bestbase(1,:)==1),psmooth,t);
%yintensity=s2.evalAt(knots(19:78));
realspectra=Y0-pop_best;


%以下为作图部分
 plot(t,Y0,'-k','LineWidth',1);hold on
%plot(t(bestbase(1,:)==1),Y0(bestbase(1,:)==1),'c*','MarkerSize',3);
 plot(t,pop_best,'-r','LineWidth',1);hold on;
 %plot(knots(19:78),yintensity,'k.','MarkerSize',15);
 %plot(t,realspectra,'-b','LineWidth',1);
 axis([0 3500 -1000 50000])
 xlabel('Raman shift(cm^{-1})','fontsize',15)
 ylabel('Intensity(a.u.)','fontsize',15)
toc
