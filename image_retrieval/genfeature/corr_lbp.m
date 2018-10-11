function [ Result ] = corr_lbp( hsv,Texton,CSA )

[M,N] = size(Texton);
HA = zeros(CSA,1);
HB = zeros(CSA,1);
MS = zeros(CSA,1);
CS = zeros(CSA,1);

Arr = Ngrids(hsv);

for i=3:M-2
    for j=3:N-2
        wa = zeros(9,1);
        
        wa(1) = Texton(i-1,j-1);
        wa(2) = Texton(i-1,j);
        wa(3) = Texton(i-1,j+1);
        
        wa(4) = Texton(i+1,j-1);
        wa(5) = Texton(i+1,j);
        wa(6) = Texton(i+1,j+1);
        
        wa(7) = Texton(i,j-1);
        wa(8) = Texton(i,j+1);
        wa(9) = Texton(i,j);
        
        value = zeros(8,1);
        value(1) = sqrt(sum(sum((Arr{i,j}-Arr{i-1,j-1}).^2)));
        value(2) = sqrt(sum(sum((Arr{i,j}-Arr{i-1,j}).^2)));
        value(3) = sqrt(sum(sum((Arr{i,j}-Arr{i-1,j+1}).^2)));
        value(4) = sqrt(sum(sum((Arr{i,j}-Arr{i+1,j-1}).^2)));
        value(5) = sqrt(sum(sum((Arr{i,j}-Arr{i+1,j}).^2)));
        value(6) = sqrt(sum(sum((Arr{i,j}-Arr{i+1,j+1}).^2)));
        value(7) = sqrt(sum(sum((Arr{i,j}-Arr{i,j-1}).^2)));
        value(8) = sqrt(sum(sum((Arr{i,j}-Arr{i,j+1}).^2)));
        
        TE = 0;
        CE = 0;
        if wa(9) == wa(1)
            CE = CE + 1;
            TE = TE + value(1);
        end
        if wa(9) == wa(2)
            CE = CE + 1;
            TE = TE + value(2);
        end
        if wa(9) == wa(3)
            CE = CE + 1;
            TE = TE + value(3);
        end
        if wa(9) == wa(4)
            CE = CE + 1;
            TE = TE + value(4);
        end
        if wa(9) == wa(5)
            CE = CE + 1;
            TE = TE + value(5);
        end
        if wa(9) == wa(6)
            CE = CE + 1;
            TE = TE + value(6);
        end
        if wa(9) == wa(7)
            CE = CE + 1;
            TE = TE + value(7);
        end
        if wa(9) == wa(8)
            CE = CE + 1;
            TE = TE + value(8);
        end
     

        if wa(9)>=0
            MS(wa(9)+1) = MS(wa(9)+1)+TE;
            HA(wa(9)+1) = HA(wa(9)+1)+sum(value);
            
            CS(wa(9)+1) = CS(wa(9)+1)+CE;
            HB(wa(9)+1) = HB(wa(9)+1)+8;
        end
        
    end
end

for i=1:CSA
    Mhist(i) = MS(i)/(HA(i)+0.00001);
    Chist(i) = CS(i)/(HB(i)+0.00001);    
end

Result = [Mhist.*(HA'/sum(HA)+1) Chist.*(HB'/sum(HB)+1)];


end
