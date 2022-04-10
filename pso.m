clear
[x, y]=meshgrid(-5:0.05:5);
z=funea(x,y);
surf(x,y,z);
pause
close
p=0.1;
ok=0;
% Setting initial population
PopSize=100;
w=10*rand(PopSize,2)-5; % wspolrzedne kazdego elementu roju
p_i=w; % inicjalizacja najlepszej pozycji elementu jako jego poczatkowych wspolrzednych
[F_g g_id] = min(funea(w(:,1),w(:,2))); 
c1 = 1;
c2 = 1;
sz = [1 100];
rand_val1 = unifrnd(0,1,sz);
rand_val2 = unifrnd(0,1,sz);
r1 = sparse(diag(rand_val1));
r2 = sparse(diag(rand_val2));
v = zeros(PopSize,2);
alfa = 0.75;
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
    %losowanie
    
    for k=1:PopSize
        %personal best
        F_p_i = funea(w(k,1),w(k,2)); %wartosc aktualnego punktu
        if F_p_i < p_i %jesli lepszy niz dotychczasowy - zamien  najlepszy na ten
            p_i = w;
        end
        %global best
        [F_g g_id] = min(funea(w(:,1),w(:,2))); 
        
        v(k,:) = alfa * v(k,:) + c1 * r1(k,k)*(p_i(k,:)-w(k,:))+c2*r2(k,k)*(w(g_id,:)-w(k,:));
       

        w(k,:) = w(k,:)+v(k,:);

        
       % r=rand;
        %t=r>d;
        %isel=sum(t)+1;
        %neww(k,:)=w(isel,:);
    end;
    %w=neww;
    
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
    
    if round(best,4) == round(best_ostatni,4)
        niezmieniony_max_i = niezmieniony_max_i + 1
    else
        niezmieniony_max_i = 0;
    end
    
    if best < best_ostatni
        best_ostatni = best;
    end
    
    if niezmieniony_max_i >= 20
        break
    end
    iteracja = iteracja + 1;
end;
plot (1:50, plot_fit, '-');

title('Zalezność sumy fitness od liczby wykonanych iteracji')
xlabel('iteracje')
ylabel('suma fit dla elementów')