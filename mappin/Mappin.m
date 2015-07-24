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
    end
end
    function submit(varargin)
        
        switch varargin{3}
            case 4
                uicontrol('units','norm','pos',[0.4 0.2 0.2 0.1],'call',{@map})
                
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
            ,C,'name','hadeeda','numbertitle','off');
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
        %         Pe*(ix+iy)
        %       i-(410+j*(464+(j-1)*(189+(j-2)*(45+(j-3)*35))))
                round((Pe+1)*(ix+iy)+ix)
        %         i
        %         j
        % %         floor((i-Tpm*j)/(j+1))
        % y
        % x

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
end