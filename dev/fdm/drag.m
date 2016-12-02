%%
%% Swedish Navy 20m-class motor torpedo boat comparison of drag to sources.
%%
%%   Copyright (C) 2016  Anders Gidenstam  (anders(at)gidenstam.org)
%%
%%   This program is free software; you can redistribute it and/or modify
%%   it under the terms of the GNU General Public License as published by
%%   the Free Software Foundation; either version 2 of the License, or
%%   (at your option) any later version.
%%
%%   This program is distributed in the hope that it will be useful,
%%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%   GNU General Public License for more details.
%%
%%   You should have received a copy of the GNU General Public License
%%   along with this program; if not, write to the Free Software
%%   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%

%% From model tow test result diagram:
%% "Resultat av släpförsök med svenska patent nr. 109626", A. F. Nordström,
%% Statens Skeppsprovningsanstalt, Göteborg, 1941-10-01.
%% available as an image from Sjöhistoriska museet as ID 2008:25:869:1 under
%% CC BY-SA.
%% One of the lines (not the main subject of the diagram) is labelled
%% "Kungl. Marinförvalt. M.T.B. (Baglietto) tvåstegsbåt" and this line
%% is reproduced below. It is not clear whether this model test result was for
%% the T21-class 20 meter MTB (not yet in service in 1941) or the
%% earlier, but wery similar, T15-class 18.7 meter MTB.
%% If this indeed is a T21-class then the efficiency of the propellers must be
%% rather low at high speed (50 kt) since the total available propulsion power
%% is 2x1500 hp (44%ish?). The T15-class boats had 2x1150 hp (58%ish?).
%% In any case the two MTB classes had very similar hull design.
%%
%% The scale of the diagram is 1500 hp/451 px.
%%         Speed (kt) Tow power (hp)
towtest = [
            10.000    113.100
            15.000    262.700
            20.000    415.700
            25.000    558.800
            30.000    678.500
            33.000    735.000
            35.000    771.600
            40.000    871.400
            45.000   1054.300
            50.000   1330.400
            52.000   1483.400
            55.000   1736.100
          ];

%% JSBSim log from a scripted acceleration test produced by
%% JSBSim  --script=aircraft/MTB_20m/dev/fdm/MTB_20m-1.xml --logdirectivefile=aircraft/MTB_20m/dev/fdm/output-all.xml
%% NOTE: The ground solidity tests in the hydro/active-norm function in
%%       Systems/MTB_20m-hydrodynamics.xml must be commented out when the
%%       boat is run in JSBSim/standalone.
fgfs = dlmread("datalog.csv", ",");

%% Extract the relevant data.
speed_kt = fgfs(:,151);
drag_lbf = fgfs(:,210);
displacement_drag_lbf = fgfs(:,208);
rudder_drag_lbf       = fgfs(:,209);
planing_drag_lbf      = abs(fgfs(:,211));
%% Conversion factors
ft_sec_from_knot = 1.6878099;
hp_from_slugft2_sec3 = 0.0018181818;
%% Power is force * speed
tow_power_hp = drag_lbf .* speed_kt .* ft_sec_from_knot .* hp_from_slugft2_sec3;
displacement_tow_power_hp = displacement_drag_lbf .* speed_kt .* ft_sec_from_knot .* hp_from_slugft2_sec3;
planing_tow_power_hp = planing_drag_lbf .* speed_kt .* ft_sec_from_knot .* hp_from_slugft2_sec3;
rudder_tow_power_hp = rudder_drag_lbf .* speed_kt .* ft_sec_from_knot .* hp_from_slugft2_sec3;

plot(towtest(:,1), towtest(:,2), "-;MTB model test, 1941;",
     speed_kt, tow_power_hp,     "+;JSBSim T21-class MTB total drag;",
     speed_kt, displacement_tow_power_hp, "+;JSBSim T21-class MTB disp. drag;",
     speed_kt, planing_tow_power_hp,      "+;JSBSim T21-class MTB plan. drag;",
     speed_kt, rudder_tow_power_hp,       "+;JSBSim T21-class MTB rud. drag;")
title("Tow power vs. speed");
xlabel("Speed (knot)");
ylabel("Tow power (hp)");
