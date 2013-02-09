%%
%%  Copyright (C) 2013  Anders Gidenstam  (anders(at)gidenstam.org)
%%  This file is licensed under the GPL license version 2 or later.
%%

FT  = 3.2808399;
g   = 32.185039;
KTS = 1.6878099;

HRPx = 12.0*FT;
HRPy =  0.0*FT;
HRPagl = 5.6;

Hull = \
 [0.00  0.24  0.48  0.75  1.20  2.00  3.70  6.17  8.29  8.30  11.70 11.74 20.00 20.00;
   0.00 -0.44 -0.87 -1.46 -1.80 -1.96 -2.09 -2.18 -2.20 -2.11 -2.13 -1.98 -1.98 -0.25].*FT;


LWL = 20 * FT; # Load water line (approx) [ft]
V = 1:1:50;           # Velocity [kts]


SLR = V./sqrt(LWL);

# First order approx. of self generated transverse wave V=Ck=1.3*sqr(Lw)
# More formally phase speed c = sqrt(g/(2*pi)*l) where l is the wave length
# Note: The divergent waves of the wake contribute little to the resistance.
#Lw = (V./1.3).^2;      # Wave length [ft]

Lw = 2*pi/g * (V.*KTS).^2;

# Amplitude (no guess at what it is yet)
# Perhaps http://www.bellona.org/reports/1193670187.13 might have something.
# Total energy per unit lenght:
#   E = 1/8 * c*g*h^2
# Flux of energy through a vertical plane strip of width 1 perpendicular
# to the wave:
#   F = 1/32 * c*g*h^2*T
#  where T is the wave period (T = 1/f = Lw/v),
#        c is the water density,
#        g is the gravity,
#        h is the wave amplitude.
#
# Assumption: Energy per second is P=drag*v
# => Aw = h = sqrt(8 * drag * v / (c*g))
# Note: The units do not add up!

# New take from
#  http://farside.ph.utexas.edu/teaching/336l/fluidhtml/node125.html
#
# In deep water:
#   D = 1/4 * \rho * g * a^2 * \omega, \omega = 2*pi / T = 2*pi * v/Lw
# gives
#   a = sqrt(2 * D * Lw / (\rho * g * pi * v))

Aw = 1;

x = 0:0.2:LWL;

# Wave height at a position x: Hw = Aw * cos(2*pi/Lw * x);
Hw = [Aw .* cos(2*pi./Lw .* x(1))' Aw .* cos(2*pi./Lw .* x(length(x)))'];

#plot(V,Lw*0.3048);

# Assume the effective water line angle is defined by the line from
# the water line at bow and stern. Not a very good one.
deltaTrim = -atan2(Hw(:,1)-Hw(:,2), LWL);

# Mean water line height - could be used for squat.
# integrate Aw .* cos(2*pi./Lw(v) .* x) from 0 to LWL
deltaWL = Aw .* Lw./(2*pi) .* sin(2*pi./Lw .* LWL)./LWL;

# Looking at one particular speed:
v=12;
Vkt = V(v)
SLR = SLR(v)
dTrim = deltaTrim(v)

deltaWLlin = interp1([0 LWL], Hw(v,:), [HRPx], 'linear')

deltaWLint = deltaWL(v)

plot(x, Aw .* cos(2*pi./Lw(v) .* x),\
     [x(1) x(length(x))], Hw(v,:),\
     Hull(1,:), Hull(2,:)+HRPagl+0*deltaWLint);
