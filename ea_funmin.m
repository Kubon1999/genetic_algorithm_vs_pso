clear
[x y]=meshgrid(-5:0.05:5);
z=funea(x,y);
surf(x,y,z);
pause
close
p=0.1;
ok=0;
% Setting initial population
PopSize=100;
w=10*rand(PopSize,2)-5;
niezmieniony_max_i = 0;
best_ostatni = 99999;
iteracja = 1;
plot_fit = zeros(50);
while 1
    % Fitness measure
    fit=funea(w(:,1),w(:,2));
    
    wmax=max(fit);
    wmin=min(fit);
    fit2=((1-p)*fit+p*wmin-wmax)/(wmin-wmax);
    plot_fit(iteracja) = sum(abs(fit));
    % Selection
    
    % Probability of selection
    sumf=sum(fit2);
    prob=fit2/sumf;
    
    d(1)=prob(1);
    for i=2:PopSize 
        d(i)=d(i-1)+prob(i);
    end;
    
    %losowanie
    
    for k=1:PopSize
        r=rand;
        t=r>d;
        isel=sum(t)+1;
        neww(k,:)=w(isel,:);
    end;
    w=neww;
    
    % Crossover
    
    vol=0.5;
    for i=1:PopSize-60;
        dw1=w(2*i,1)-w(2*i-1,1);
        dw2=w(2*i,2)-w(2*i-1,2);
        alpha=vol*(rand-0.5);
        
        w(2*i-1,:)=[w(2*i-1,1)+dw1*alpha w(2*i-1,2)+dw2*alpha];
        w(2*i,:)=[w(2*i,1)-dw1*alpha w(2*i,2)-dw2*alpha];
    end; 
    
    % Mutation
    
    % Selecting one individual
    
    i=ceil(rand*100);
    
    w(i,:)=w(i,:)+randn(1,2);
    
    % Visualisation
    
    [x y]=meshgrid(-5:0.05:5);
    z=funea(x,y);
    contour(x,y,z,10);
    hold on;
    plot(w(:,1),w(:,2),'ko');
    hold off;
    pause;
    
    ok=ok+1;
    [best ii]=min(funea(w(:,1),w(:,2))); 
    [ok  best w(ii,:)]
    
    if round(best,1) == round(best_ostatni,1)
        niezmieniony_max_i = niezmieniony_max_i + 1
    else
        niezmieniony_max_i = 0;
    end
    
    if best < best_ostatni
        best_ostatni = best;
    end
    
    if niezmieniony_max_i >= 10
        break
    end
    iteracja = iteracja + 1;
end;
hold on;
plot (1:50, plot_fit, '-');
title('Zalezność sumy fitness od liczby wykonanych iteracji');
xlabel('iteracje');
ylabel('suma fit dla elementów');
hold off;
