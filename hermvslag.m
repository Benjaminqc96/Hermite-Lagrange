clear
close all
clc
syms x lp
fu=input('Ingrese la funcion: ');
cont=input('Cuantos nodos?: ');
fprima=diff(fu,x);
for i=1:cont
    fprintf('Nodo %d: ',i)
    nod(i)=input('');
end
for i=1:cont
    for k=1:cont
        if i~=k
        lp(i,k)=(x-nod(k))/(nod(i)-nod(k));
        else
            lp(i,k)=1;
        end 
       
    end
end
lpp=prod(lp,2);
for j=1:cont
fnod(j)=double(subs(fu,nod(j)));
fdnod(j)=double(subs(fprima,nod(j)));
end
for q=1:cont
    p(q)=fnod(q)*lpp(q);
end
pp=sum(p);
HC=zeros(cont);
for u=1:cont
    HC(u,:)=sym2poly(lpp(u));
    hcc(u)=poly2sym(HC(u,:));
    hcd(u)=diff(hcc(u),x);
    hde(u)=double(subs(hcd(u),fdnod(u)));
    hl(u)=(1-2*(x-nod(u))*(hde(u)))*((hcc(u))^2);
    hd(u)=(x-nod(u))*((hcc(u))^2);
end
for o=1:cont
    hfl(o)=hl(o)*(fnod(o));
    hfd(o)=hd(o)*(fdnod(o));
end
hf=sum(hfl)-sum(hfd);
%z=0:.01:30;
%ejez=double(subs(hf,z));
ezplot(hf)
grid on
hold on
ezplot(pp)
for i=1:cont
    plot(nod(i),fnod(i),'o')
end
hold off
