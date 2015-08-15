function d = gggg(lat2,lat1,lon2,lon1)
%radians = degrees * pi / 180
% dLat=[];
% dLat=[];
% lat1=30.070224333333332;
% lat2=30.07021183333333;
% lon1=31.18981408333333;
% lon2=31.189799416666666;



% a =[]; 
% c=[];
% d=[];
% f=[];
% g=[];

R = 6371000; % km
 dLat = (RADIANS(lat2)-RADIANS(lat1));
 dLon = (RADIANS(lon2)-RADIANS(lon1));
%  lat1 = lat1;
%  lat2 = lat2;

a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) *cos(lat1) * cos(lat2); 
f=sqrt(a);
g=sqrt(1-a);

 c = 2*atan2(f,g); 
d = R * c;
end