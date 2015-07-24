function[X , Y , Z] = Ginput3D(N)
X = [] ; Y = [];  Z = [] ;
figure;
axis([0 1 0 1 0 1 ])
for no = 1:N
    gginp()
    set(ax,'xgrid','on','ygrid','on','zgrid','on')
    waitfor(ax,'xgrid','off')
    close(figure_handle)
    hold on
    grid on
    annotation('textbox',[X-X/1000 Y+Y/10000 0.12 0.14], 'str',{X;Y;Z})
    p  = plot3(X,Y,Z,'s');
    X = [X get(p,'xdata')];
    Y = [Y get(p,'ydata')];
    Z = [Z get(p,'zdata')];
    hold off
end 
    function  gginp(varargin)
        
        z = 0:0.01:1;
        Len = length(z);
        figure_handle = figure;
        ax =axes();
        axis([0 1 0 1]);
        grid on
        [X ,Y]= ginput(1);
        x(1:Len) = X ;
        y(1:Len) = Y ;
        plot3(x,y,z,'b');
        axis([0 1 0 1 0 1])
        dcm_obj = datacursormode(figure_handle);
        set(dcm_obj,'Enable','on','UpdateFcn',@myfunction)
       
    end


    function output_txt = myfunction(~,event_obj)
        
        output_txt = get(event_obj,'Position');
        Z = output_txt(3);
        set(ax ,'xgrid','off')
        set(dcm_obj,'Enable','off')
        
       
    end
end