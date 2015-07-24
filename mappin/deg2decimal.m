function decci = deg2decimal(bef,aft)
        
        decci =  floor(bef/100) +((((bef/100)-floor(bef/100))*100)+aft/1e+5)/60;
end