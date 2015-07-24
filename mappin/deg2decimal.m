function decci = deg2decimal(bef,aft,varargin)
        min =varargin{1}/60; 
        decci =  floor(bef/100) +(((((bef/100)-floor(bef/100))*100)+aft/1e+5)+min)/60;
end