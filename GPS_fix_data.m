function [lat,lon]=GPS_fix_data(COMPort ,BaudRate,swt)
lon1 = [];lat1 = [];
lon2 = [];lat2 = [];
lon3 = [];lat3 = [];

format long e
tic
figure();

      hold on

if strcmp(COMPort(1:3),'COM') && isa(BaudRate,'double')
    
    G = serial(COMPort,'baudrate',BaudRate);
else
    k = sprintf('\n\n%s \n    ex :\n        GPS_fix_data(%s,9600,%d) ',...
        'you have to write the input as the following','COM3',1);
    disp(k)
end 

connnect(swt)

    function connnect(swt)
        switch swt
            case 1
                fopen(G);
                G.BytesAvailableFcnMode = 'terminator';
                G.BytesAvailableFcn = @FNCstrings;
                
            case 0
                fclose(G);
                instrreset
        end
    end

    function FNCstrings(varargin)
        
        m_s_g = fscanf(G,'%s');
        M_S_G  = sscanf(m_s_g,'$GP%s');
        if length(M_S_G)>3
            switch M_S_G(1:3)
                case 'GGA' %Global Positioning System Fix Data 
                    
                    digitss = sscanf(M_S_G,...
                        'GGA,%f,%d.%d,N,%d.%d,E,%d,%d,%f,%f,M,%f,M,,%d*%d');
                     di = length(digitss);
                     
                     if di < 3 
                         return
                     else
                         lat1 = vertcat(lat1,deg2decimal(digitss(2),digitss(3)));
                         lon1 = vertcat(lon1,deg2decimal(digitss(4),digitss(5)));
                         lon = lon1;
                         lat = lat1;
                         lon = fscalef(lon,31.1098,31.1898,1,20)
                         lat = fscalef(lat,30.0707,30.0711,1,20)
                         if length(lon) > 3
                            lonn = mean(lon(end-3:end));
                            latt = mean(lat(end-3:end));
                            plot(latt,lonn,'sr');
                         elseif length(lon) > 10
                             lonn = mean(lon(end-floor(3*length(lon)/4):end));
                             latt = mean(lat(end-floor(3*length(lat)/4):end));
                             plot(latt,lonn,'sr');
                         end
                      %   hieght = [digitss(9) digitss(10)];
                     end
                     
                case 'RMC' %Recommended Minimum sentence C
                    %RMC,022307.00,A,2959.48603,N,03118.41348,E,0.431,,100715,,,D*7A
                    %RMC,123519,A,4807.038,N,01131.000,E,       022.4,084.4,230394,003.1,W*6A
                     
                    %i = i +1;
                    digitss = sscanf(M_S_G,...
                        'RMC,%f,A,%d.%d,N,%d.%d,E,%f,%d,%d');
                     di = length(digitss);
                     
                     if di < 3 
                         return
                     else
                         lon2 = vertcat(lon2,deg2decimal(digitss(4),digitss(5)));
                         lat2 = vertcat(lat2,deg2decimal(digitss(2),digitss(3)));
                         lon = lon2;
                         lat = lat2;
                         lon = fscalef(lon,31.1098,31.1898,1,20)
                         lat = fscalef(lat,30.0707,30.0711,1,20)
                         if length(lon) > 3
                            lonn = mean(lon(end-3:end));
                            latt = mean(lat(end-3:end));
                            plot(latt,lonn,'sr');
                         elseif length(lon) > 10
                             lonn = mean(lon(end-floor(3*length(lon)/4):end));
                             latt = mean(lat(end-floor(3*length(lat)/4):end));
                             plot(latt,lonn,'sr');
                         end
                     end
                case 'GLL'
                    
                       %$GPGLL,2959.48579,N,031=18.41424,E,022305.00,A,D*66
                    digitss = sscanf(M_S_G,...
                        'GLL,%d.%d,N,%d.%d,E,%f');
                     di = length(digitss);
                     if di < 3 
                         return
                     else
                         lon3 = vertcat(lon3,deg2decimal(digitss(3),digitss(4)));
                         lat3 = vertcat(lat3,deg2decimal(digitss(1),digitss(2)));
                         lon = lon3;
                         lat = lat3;
                         lon = fscalef(lon,31.1098,31.1898,1,20)
                         
                         lat =fscalef(lat,30.0707,30.0711,1,20)
                         if length(lon) > 3
                            lonn = mean(lon(end-3:end));
                            latt = mean(lat(end-3:end));
                            plot(latt,lonn,'sr');
                         elseif length(lon) > 10
                             lonn = mean(lon(end-floor(3*length(lon)/4):end));
                             latt = mean(lat(end-floor(3*length(lat)/4):end));
                             plot(latt,lonn,'sr');
                         end
                     end
                     
            end
           
                
                
        end
    end
    
end
