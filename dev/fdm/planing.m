%%
%% Swedish Navy 20m-class motor torpedo boat estimation of planing.
%%
%%   Copyright (C) 2015  Anders Gidenstam  (anders(at)gidenstam.org)
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

deg = pi/180;

%% Cases
tau = (0:13)*deg;
h_RP = 2.1;

%% Forebody as straight flat profile.
%% NOTE: In reality it is curved and V-shaped.
x0_f = -12.00;
x1_f =  -3.71;
zk_f =  -2.20;
b_f  =   4.50;
Forebody = [x0_f x1_f];

%% Middlebody as straight flat profile.
%% NOTE: In reality it is V-shaped.
x0_m =  -3.67;
x1_m =  -0.30;
zk_m =  -2.13;
b_m  =   4.50;
Middlebody = [x0_m x1_m];

%% Afterbody as straight flat profile.
%% NOTE: In reality it is V-shaped.
x0_a =  -0.26;
x1_a =   8.00;
zk_a =  -1.96;
b_a  =   3.52;
Afterbody = [x0_a x1_a];

%% Entry points of the planing surfaces along the x-axis.
xe_f = (h_RP./cos(tau) + zk_f)./tan(tau);
xe_m = (h_RP./cos(tau) + zk_m)./tan(tau);
xe_a = (h_RP./cos(tau) + zk_a)./tan(tau);

%% Wetted keel lengths
Lk_f = max(0, min(x1_f - xe_f, x1_f - x0_f));
Lk_m = max(0, min(x1_m - xe_m, x1_m - x0_m));
Lk_a = max(0, min(x1_a - xe_a, x1_a - x0_a));

%% Plot the planing surfaces for one h_RP and tau value.
_h_RP = h_RP;
_tau = 2*deg;

_Xwater = [-14 14];
_Ywater = [0 0];

_Xhull = [Forebody.*cos(_tau) + zk_f.*sin(_tau)   \   
          Middlebody.*cos(_tau) + zk_m.*sin(_tau) \
          Afterbody.*cos(_tau) + zk_a.*sin(_tau)];
_Yhull = [_h_RP + zk_f - Forebody.*sin(_tau)      \
          _h_RP + zk_m - Middlebody.*sin(_tau)    \
          _h_RP + zk_a - Afterbody.*sin(_tau)]';

plot(zeros(1,11), h_RP, 'x',
     _Xhull, _Yhull, 'r-',
     _Xwater, _Ywater, 'b-');
xlim(_Xwater);
ylim(_Xwater);
