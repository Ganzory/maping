function Mappin

clear ; clc ; close
Mapps = [0 0];
coord = [];
%% first figure
h = figure('menubar','none','units','norm','pos',[0.3 0.3 0.4 0.4],'numbertitle','off');
coor = {'lat1','lat2';'long1','long2'};
cooor = [30.0707,30.0711;31.1098,31.1898];
for iiii = 1:2
    for jjjj = 1:2
        uicontrol('style','text','units','norm','pos',[-0.19+iiii/3 0.08+jjjj/4 0.08 0.05],'str',coor{iiii,jjjj})
        k(iiii,jjjj) = uicontrol('style','edit','units','norm','pos'...
            ,[-0.15+iiii/3 0.1+jjjj/3.5 0.3 0.2],'call',{@submit,iiii+jjjj}...
            ,'str',cooor(iiii,jjjj));
        uicontrol('units','norm','str','Connect','pos',[0.7 0.1 0.2 0.1],'call',{@submit,1})
    end
end
    function submit(varargin)
        
        switch varargin{3}
            case 1
                GPS_fix_data('COM23',57600,0)
                GPS_fix_data('COM23',57600,1)
            case 4
                uicontrol('units','norm','str','Submitt Data','pos',[0.4 0.2 0.2 0.1],'call',{@map})
                
        end
        for lon = 1:2
            for lat = 1:2
                coord(lat,lon) = str2double(get(k(lat,lon),'str'));
            end
        end
        
    end
%% mapping main program
    function map(varargin)
        close(h)
        
        c = [0.15 0.5 0.15];
        C = 'k';
        T = 'w';
        X = 0 ; 
        Y = 0 ; 

        h_fig= figure('menubar','none','units','norm','pos',[0.1 0.1 0.8 0.8],'color'...
            ,C,'name','Map','numbertitle','off');
        set(h_fig,'KeyPressFcn',{@tickk});   

        errorr = uicontrol('style','text','units','norm','pos',[0.2 0.85 0.2 0.1],...
                            'backgroundcolor',C,'str','Press any Key Then click','foregroundcolor',T...
                            ,'fontsize',14);

         buutons = { '  ' , 'table of values','Reset','plot b2a'};               
         for ii = 2:4               
          uicontrol('style','push','units','norm','pos',[0.85 0.4-ii/10 0.15 0.1],...
                           'str',buutons{ii},'foregroundcolor',T...
                           ,'backgroundcolor',C,'fontsize',14,'call',{@myFNC,ii+2 })
         end


        strr = {'X = '  ; 'Y = '};
        for iu = 1:2
            Buttt(iu) =uicontrol('style','edit','units','norm','pos',[0.3+iu/10 0.9 0.08 0.08],...
                'backgroundcolor',C,'str',strr(iu),'foregroundcolor',T...
                ,'fontsize',14,'call',{@myFNC,1+iu});
        end

        chaar = {'A'  'B'  'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S'} ;

        axes('units','norm','pos',[0.05 0.05 0.5 0.8],...
        'xlim',[1 20],'ylim',[1 20],'color',C,'box','on'...
        ,'xgrid','on','ygrid','on','gridlinestyle','-'...
          ,'xcolor',c,'ycolor',c...
          ,'XTick',1:19,'Ytick',1:19,'Xticklabel',chaar); 

        hold on

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% the main functions

        function myFNC(varargin)


               switch varargin{3}

                    case 1 %mouse inut
                        [x,y] = ginputc(1,'color',T);
                        X = floor(x) ; Y = floor(y);

                        if 0<X && X<20 && 0<Y && Y<20 && (isequal(X,Mapps(end,1))==0 || isequal(Y,Mapps(end,2))==0)
                            Mapps = [Mapps ; [X Y]];
                            plot(X+0.5 , Y+0.5 , 's'...
                            ,'MarkerSize',25,...
                            'MarkerEdgeColor','w',...
                            'MarkerFaceColor',[0.5,0.5,0.5])
                            set(errorr , 'str','Auto Positioning by Mouse')

                            strr = { chaar{X} ; Y};
                            for iuu = 1:2
                                set(Buttt(iuu),'str' ,strr(iuu,1)) 
                            end
                        end


                    case 4 % table figure
                        

                         figure('menubar','none','numbertitle','off','units','norm','pos',[0.625 0.1 0.15 0.8],'color'...
                                         ,C);
                                     Mappp = {'X' , 'Y'};
                         for j = 1:2
                            uicontrol('style','text','units','norm','pos',[0.1+j/5 0.9 0.15 0.06],...
                                        'backgroundcolor',C,'str',Mappp{j},'foregroundcolor',T...
                                        ,'fontsize',14);
                         end
                        scale = size(Mapps);
                        for j = 1:scale(2)
                            for iii = 2 : scale(1)
                                STRR = {chaar{Mapps(iii,1)} ,Mapps(iii,2)};
                                save('LastMapData')
                               uicontrol('style','text','units','norm','pos',[0.1+j/5 0.9-iii/15+1/15 0.15 0.06],...
                                'backgroundcolor',C,'str',STRR{j},'foregroundcolor','w'...
                                ,'fontsize',14);
                            end
                        end
                    case 5 %reset

                        cla
                        Mapps= [0 0];

                   case 2 % X pos
                        x = get(Buttt(1),'str');
                        xx = str2double(x{1});
                        X = floor(xx);
                        set(errorr , 'str','setting X position')

                   case 3 % Y pos

                       y = get(Buttt(2),'str');
                       yy = str2double(y);
                       Y = floor(yy);
                       set(errorr , 'str','setting Y position')
                   case 6 

                           if 0<X && X<20 && 0<X && X<20 || (isequal(X,Mapps(end,1))==0 && isequal(Y,Mapps(end,2))==0)  
                                Mapps = [Mapps ; [X Y]];
                                plot(X+0.5 , Y+0.5 , 's'...
                                ,'MarkerSize',25,...
                                'MarkerEdgeColor','w',...
                                'MarkerFaceColor',[0.5,0.5,0.5])
                           end
                end

        end
%%  condition off signal
        Navv = [];
        y = 1 ;
        x = 1 ;
        i = 0 ;
        j = 0 ;
        Pe = 1;
            function tickk(varargin)
                
                
                r = 6.063045451 ;  
                Tpm = 2.1 ;

                ix = Tpm*(18-j);
                iy = Tpm*(18-j);

                %+j*(464+(j-1)*(82+(j-2)*(45))))
                i = i + 1; %189 , 250 ,302 ,347 , 382 ,410 , 428 , 439 ,441
                if round(i-(350+j*(542-(j-1)*(60.5-(j-2)*(10.659-(j-3)*(2.74233333-(j-4)*(0.47-(j-5)*(0.00346666+(j-6)*(0.0321-(j-7)*0.013512)))))))))== round((Pe+1)*(ix+iy)+ix) 
                    Pe = Pe + 1;
                    j = j+1;
                end
        
                if  y < 19-j && x == 1+j 

                    y = y + pi*r/160;

                elseif x > 1+j && y < 1+j     

                    x = x - pi*r/160; 

                elseif x < 19-j && floor(y) == 19-j

                    x = x +pi*r/160;   

                elseif  y >= 1+j && floor(x) == 19-j

                    y = y - pi*r/160;


                else

                    x = round(x);
        %             y = round(y);

                end
                Navv = [Navv ;x  y];
                plot(Navv(1:end,1)+0.5,Navv(1:end,2)+0.5,'w')
            end

    end

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
                         lon = fscalef(lon,coord(2,1),coord(2,2),1,20)
                         
                         lat = fscalef(lat,coord(1,1),coord(1,2),1,20)
                         if length(lon) > 3
                            lonn = mean(lon(end-3:end));
                            latt = mean(lat(end-3:end));
                            plot(latt,lonn,'sr');
                         elseif length(lon) > 10
                             lonn = mean(lon(end-length(lon)/7:end));
                            latt = mean(lat(end-length(lat)/7:end));
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
                         lon = fscalef(lon,coord(2,1),coord(2,2),1,20)
                         
                         lat = fscalef(lat,coord(1,1),coord(1,2),1,20)
                         if length(lon) > 3
                            lonn = mean(lon(end-3:end));
                            latt = mean(lat(end-3:end));
                            plot(latt,lonn,'sr');
                         elseif length(lon) > 10
                             lonn = mean(lon(end-length(lon)/7:end));
                            latt = mean(lat(end-length(lat)/7:end));
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
                         lon = fscalef(lon,coord(2,1),coord(2,2),1,20)
                         
                         lat = fscalef(lat,coord(1,1),coord(1,2),1,20)
                         if length(lon) > 3
                            lonn = mean(lon(end-3:end));
                            latt = mean(lat(end-3:end));
                            plot(latt,lonn,'sr');
                         elseif length(lon) > 10
                             lonn = mean(lon(end-length(lon)/7:end));
                            latt = mean(lat(end-length(lat)/7:end));
                            plot(latt,lonn,'sr');
                         end
                     end
                     
            end
           
                
                
        end
    end
    
end
end