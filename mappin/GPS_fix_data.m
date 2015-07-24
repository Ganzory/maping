function GPS_fix_data(COMPort ,BaudRate,swt)
lon1 = [];lat1 = [];
lon2 = [];lat2 = [];
lon3 = [];lat3 = [];
longi = []; latit=[];
format long e
tic
%lon = []; lat = [];%i = 0;
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
                     
                     if di < 3 &&(digitss(2)+digitss(3)/1e+5)/100 < 10 && (digitss(4)+digitss(5)/1e+5)/100 < 10
                         return
                     else
%                          no_of_sat = digitss(7);
%                          Fix_quality =  digitss(6);
%                          Horizontal_dilution_of_position = digitss(8);
% %                           0 = invalid
% % %                         1 = GPS fix (SPS)
% % %                         2 = DGPS fix
% % %                         3 = PPS fix
% % % 			              4 = Real Time Kinematic
% % % 			              5 = Float RTK
% % %                         6 = estimated (dead reckoning) (2.3 feature)
% % % 			              7 = Manual input mode
% % % 			              8 = Simulation mode
%                          timeaclock = digitss(1);
                         lat1 = vertcat(lat1,deg2decimal(digitss(2),digitss(3)));
                         lon1 = vertcat(lon1,deg2decimal(digitss(4),digitss(5)));
                      %   hieght = [digitss(9) digitss(10)];
                     end
                case 'GSA'  %Satellite status
%                       $GPGSA,A,3,04,05,,09,12,,,24,,,,,2.5,1.3,2.1*39
% 
% Where:
%      GSA      Satellite status
%      A        Auto selection of 2D or 3D fix (M = manual) 
%      3        3D fix - values include: 1 = no fix
%                                        2 = 2D fix
%                                        3 = 3D fix
%      04,05... PRNs of satellites used for fix (space for 12) 
%      2.5      PDOP (dilution of precision) 
%      1.3      Horizontal dilution of precision (HDOP) 
%      2.1      Vertical dilution of precision (VDOP)
%      *39      the checksum data, always begins with *

                case 'GSV'
            
%                     
%                      $GPGSV,2,1,08,01,40,083,46,02,17,308,41,12,07,344,39,14,22,228,45*75
% 
% Where:
%       GSV          Satellites in view
%       2            Number of sentences for full data
%       1            sentence 1 of 2
%       08           Number of satellites in view
% 
%       01           Satellite PRN number
%       40           Elevation, degrees
%       083          Azimuth, degrees
%       46           SNR - higher is better
%            for up to 4 satellites per sentence
%       *75          the checksum data, always begins with *

                case 'RMC' %Recommended Minimum sentence C 
                    %RMC,022307.00,A,2959.48603,N,03118.41348,E,0.431,,100715,,,D*7A
                    %RMC,123519,A,4807.038,N,01131.000,E,       022.4,084.4,230394,003.1,W*6A
                     
                    %i = i +1;
                    digitss = sscanf(M_S_G,...
                        'RMC,%f,A,%d.%d,N,%d.%d,E,%f,%d,%d');
                     di = length(digitss);
                     
                     if di < 3 && (digitss(4)+digitss(5)/1e+5)/100 < 10 && (digitss(2)+digitss(3)/1e+5)/100 <10
                         return
                     else
                         lon2 = vertcat(lon2,deg2decimal(digitss(4),digitss(5)));
                         lat2 = vertcat(lat2,deg2decimal(digitss(2),digitss(3)));
                     end
                case 'GLL'
                    
                       %$GPGLL,2959.48579,N,031=18.41424,E,022305.00,A,D*66
                    digitss = sscanf(M_S_G,...
                        'GLL,%d.%d,N,%d.%d,E,%f');
                     di = length(digitss);
                     
                     if di < 3 && (digitss(3)+digitss(4)/1e+5)/100 <10 && (digitss(1)+digitss(2)/1e+5)/100 <10
                         return
                     else
                         lon3 = vertcat(lon3,deg2decimal(digitss(3),digitss(4)));
                         lat3 = vertcat(lat3,deg2decimal(digitss(1),digitss(2)));
                     end
                     
            end
           
             
                %longi2 = mean(lon2)
                %latit2 = mean(lat2)
                %coord2 = sprintf('%f,%f,blue',latit2,longi2);
               % wmmaker(latit2,longi2,'zoom',19,'marker',coord2)
                %longi3 = mean(lon3)
                %latit3 = mean(lat3)
               % coord3 = sprintf('%f,%f,blue',latit3,longi3);
               % wmmaker(latit3,longi3,'zoom',19,'marker',coord3)
                if length(lon1) > 10 && length(lat1) > 10 || length(lon2) > 10  && length(lat2) > 10||length(lon3) > 10  && length(lat3) > 10
                    longi(1) = mean(lon1);
                    latit(1) = mean(lat1);
                    longi(2) = mean(lon2);
                    latit(2) = mean(lat2);
                    longi(3) = mean(lon3);
                    latit(3) = mean(lat3);

               % coord1 = sprintf('%f,%f,blue',latit1,longi1);
%                wmmarker(latit(1),longi(1)) 
%                wmmarker(latit(2),longi(2))
%                wmmarker(latit(3),longi(3))
                    GPS_fix_data('COM3',9600,0)
                    savv
                end
                
                
        end
    end
    function savv(varargin)
        fix_data = load('fix_data.mat');
        longi = [ fix_data.longi; longi];
        latit = [ fix_data.latit; latit];
        save('fix_data.mat')
         toc
    end
function decci = deg2decimal(bef,aft)
        
        decci =  floor(bef/100) +((((bef/100)-floor(bef/100))*100)+aft/1e+5)/60;
end
end
% radians = degrees * PI / 180
% var R = 6371; // km
% var dLat = (lat2-lat1).toRad();
% var dLon = (lon2-lon1).toRad();
% var lat1 = lat1.toRad();
% var lat2 = lat2.toRad();
% 
% var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
%         Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
% var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
% var d = R * c;