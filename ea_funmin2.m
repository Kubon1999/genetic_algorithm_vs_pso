clear
[x y]=meshgrid(-5:0.05:5);
z=funea(x,y);
surf(x,y,z);
pause
close
ok=0;

% tworzenie populacji
PopSize=100;
w=10*rand(PopSize,2)-5;

while 1
    % funkcja celu
    % i  funkcja jakosci
	
    fit = FitnesMeasure(w);   
 
    
    % selekcja

    selected = Selection(fit,w);

    
    % krzyzowanie 
     
    crossedO = CrossOver(selected);   
    
    % mutacja np. jednego, wybranego osobnika    

     mutated = Mutation(crossedO);    

     w=mutated;

    % wizualizacja    
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
    
end;
