%%
%%  Copyright (C) 2013  Anders Gidenstam  (anders(at)gidenstam.org)
%%  This file is licensed under the GPL license version 2 or later.
%%

%% Formulas
%% ([1] ICMM_TGZielinski_FluidWaves.slides.pdf,
%%  [2] http://http.developer.nvidia.com/GPUGems/gpugems_ch01.html,
%%  [3] http://en.wikipedia.org/wiki/Airy_wave_theory and so on)
% Wave
%  length              L     [m]
%  amplitude           A     [m]
%  angular frequency   omega [rad/s]
%  frequency           f     [1/s]
%  wave number         k     [rad/m]
%  phase velocity      c     [m/s]
%  phase speed         S     [m/s]
%  wave number         k     [rad/m]?
%  period              T     [s]
%  direction           D     unit vector
%
%  wave(x,y,t)     = A*cos(dot(D,(x,y))*k - omega*t)
%  dwave(x,y,t)/dx = 
%  dwave(x,y,t)/dy = 
%
%  omega = 2*pi / T = 2*pi * f
%  k = 2*pi / L
%  c = omega / k = L / T = L * f
%
%  In deep water [1]: (Check c!)
%    omega = sqrt(g*k)
%    c = sqrt(g * k)
%
%  In finite depth (depth h) [1]:
%    omega = sqrt(g * k * tanh(k*h))
%    c = sqrt(g/k * tanh(k*h))
%
%  In shallow water (depth h) [1]:
%    omega = sqrt(g*h) * k
%    c = sqrt(g*h) (also the group velocity here!)

M   = 3.2808399;
g   = 32.185039;
KTS = 1.6878099;
DEG = pi/180;

# The hull
HRPx = 12.0*M;
HRPy =  0.0*M;
HRPagl = 5.6;

Hull = \
 [0.00  0.24  0.48  0.75  1.20  2.00  3.70  6.17  8.29  8.30  11.70 11.74 20.00 20.00;
   0.00 -0.44 -0.87 -1.46 -1.80 -1.96 -2.09 -2.18 -2.20 -2.11 -2.13 -1.98 -1.98 -0.25].*M;

LWL  = 20 * M; # Load water line (approx) [ft]
BEAM =  5 * M; # Water line beam (approx) [ft]

course = 0 * DEG; # [rad]

# Sinus shaped swell
Aw = 1.0 * M; # [ft]
Lw = 10.0 * M; # [ft]

# direction
Dw = 30 * DEG; #[0:5:360] * DEG; # [rad]

# Wave speed [ft/s]
Vw = sqrt(g * 2*pi / Lw);

# Wave period [s]
Tw = Lw./Vw;

# Effective wave speeds and lengths
loVw = Vw.*cos(Dw);
trVw = Vw.*sin(Dw);
loLw = Lw./cos(Dw);
trLw = Lw./sin(Dw);

x = [0:0.5:100] * M;

wave = Aw * cos(2*pi./Lw .* x);

plot(x, Aw * cos(2*pi./Lw .* x),\
     x, Aw * cos(2*pi./Lw .* x),\
     x, Aw * cos(2*pi./Lw .* x));

#plot(x, wave,
#     Hull(1,:), Hull(2,:)+HRPagl);

t = 0:0.1:60;
#plot(t, Aw * cos(2*pi.*Vw/Lw .*t));

