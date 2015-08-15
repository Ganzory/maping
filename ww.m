function ww(strr)
for kk = 1:length(strr)
wm1 = webmap(strr{kk});
centerLatitude = 30.0711;
centerLongitude = 31.1898;
zoomLevel = 16;
wmcenter(wm1, centerLatitude, centerLongitude, zoomLevel)
pause(10)
end
end