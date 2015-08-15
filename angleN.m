function seta = angleN(latit1,long1,latit2,long2)

d1 = distancee(latit2,latit1,long2,long1);
d2 = distancee(latit2,latit1,long2,long2);
seta = acos(d2/d1);
end