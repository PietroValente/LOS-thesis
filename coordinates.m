viewer = siteviewer("Buildings","map.osm");

%%
%Set transmitter
tx = txsite("Latitude",45.04133034557901, ...
    "Longitude",7.73530213404474, ...
    "AntennaHeight",30);

%%
%Import receiver coordinates
filename = 'coordinates.txt';
delimiterIn = ' ';
headerlinesIn = 1;
rxLocations = importdata(filename,delimiterIn,headerlinesIn);

%%
%Set receivers
rx = rxsite( ...
    "Latitude",rxLocations.data(:,1), ...
    "Longitude",rxLocations.data(:,2), ...
    "AntennaHeight",2*(ones(1214, 1)).');

%%
%Show points
show(tx)
show(rx)

%%
%LOS function for each receivers

FINAL = ones(1214,3);

for i = 1:1214
    los(tx,rx(1,i))
    FINAL(i,1) = rxLocations.data(i,1);
    FINAL(i,2) = rxLocations.data(i,2);
    FINAL(i,3) = los(tx,rx(1,i));
end

pm = propagationModel("raytracing");
rays = raytrace(tx,rx,pm);
