function d = distancee(Lat2,Lat1,Long2,Long1)

RadiusEarth = 6371000;

d = RadiusEarth*acos(cos(RADIANS(90-Lat1)) *cos(RADIANS(90-Lat2)) +sin(RADIANS(90-Lat1)) *sin(RADIANS(90-Lat2)) *cos(RADIANS(Long1-Long2)));
end