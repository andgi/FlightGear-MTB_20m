###############################################################################
##
## Swedish Navy 20m-class motor torpedo boat for FlightGear.
##
##  Copyright (C) 2012 - 2025  Anders Gidenstam  (anders(at)gidenstam.org)
##  This file is licensed under the GPL license v2 or later.
##
###############################################################################


###############################################################################
var ground = func {
    # Send the current ground level to the JSBSim hydrodynamics model.
    var pos = geo.aircraft_position();
    var material = geodinfo(pos.lat(), pos.lon());
    if (!(material[1] == nil) and contains(material[1], "solid") and
        !material[1].solid) {
        setprop("/fdm/jsbsim/hydro/environment/water-level-ft",
                getprop("/position/ground-elev-ft") #+
                #getprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft")
               );
    }

    # Connect the FlightGear wave model to the JSBSim hydrodynamics wave model.
    # Properties:                  [unit]   (Fragment shader)
    #   /environment/wave/amp      [m?]     (WaveAmp)
    #   /environment/wave/angle    [deg?]   (WaveAngle)
    #   /environment/wave/dangle   [deg?]   (WaveDAngle)
    #   /environment/wave/factor            (WaveFactor)
    #   /environment/wave/freq     [Hz?]    (WaveFreq)
    #   /environment/wave/sharp
    setprop("/fdm/jsbsim/hydro/environment/waves-from-deg",
            getprop("/environment/wave/angle") - 90.0);
    #setprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft",
    #        getprop("/environment/wave/amp"));
    #setprop("/fdm/jsbsim/hydro/environment/wave-length-ft",
    #        1.0/getprop("/environment/wave/freq"));

    # Connect the JSBSim hydrodynamics wave model with the custom water shader.
    setprop("environment/waves/time-sec",
            getprop("/fdm/jsbsim/simulation/sim-time-sec"));
    setprop("environment/waves/from-deg",
            getprop("/fdm/jsbsim/hydro/environment/waves-from-deg"));
    setprop("environment/waves/length-ft",
            getprop("/fdm/jsbsim/hydro/environment/wave-length-ft"));
    setprop("environment/waves/amplitude-ft",
            getprop("/fdm/jsbsim/hydro/environment/wave-amplitude-ft"));
    setprop("environment/waves/angular-frequency-rad_sec",
            getprop("/fdm/jsbsim/hydro/environment/wave/angular-frequency-rad_sec"));
    setprop("environment/waves/wave-number-rad_ft",
            getprop("/fdm/jsbsim/hydro/environment/wave/wave-number-rad_ft"));
}
ground_timer = maketimer(0.0, ground);

var _MTB20m_initialized = 0;
setlistener("/sim/signals/fdm-initialized", func {
    if (_MTB20m_initialized) return;
    aircraft.livery.init("Aircraft/MTB_20m/Models/Liveries");
    ground_timer.start();
    print("Hydrodynamics initialized.");
    _MTB20m_initialized = 1;
});

###############################################################################

var clutches =
    [props.globals.getNode("controls/engines/transmission[0]/clutch"),
     props.globals.getNode("controls/engines/transmission[1]/clutch")];
var reversers =
    [props.globals.getNode("controls/engines/transmission[0]/reverse"),
     props.globals.getNode("controls/engines/transmission[1]/reverse")];

###############################################################################
# On-screen displays
var left  = screen.display.new(20, 10);
var right = screen.display.new(-300, 10);

left.add("/fdm/jsbsim/sim-time-sec");
left.add("/fdm/jsbsim/hydro/active-norm");
left.add("/fdm/jsbsim/hydro/true-course-deg");
left.add("/fdm/jsbsim/hydro/beta-deg");
left.add("/fdm/jsbsim/hydro/pitch-deg");
left.add("/fdm/jsbsim/hydro/roll-deg");
left.add("/fdm/jsbsim/hydro/hull/pitch-deg");
left.add("/fdm/jsbsim/hydro/hull/roll-deg");
left.add("/fdm/jsbsim/hydro/height-agl-ft");
left.add("/fdm/jsbsim/inertia/cg-x-in");
left.add("/fdm/jsbsim/inertia/cg-z-in");
left.add("/fdm/jsbsim/fcs/rudder-pos-norm");
left.add("/fdm/jsbsim/hydro/fdrag-lbs");
left.add("/fdm/jsbsim/hydro/displacement-drag-lbs");
left.add("/fdm/jsbsim/hydro/planing-drag-lbs");
left.add("/fdm/jsbsim/hydro/fbz-lbs");
left.add("/fdm/jsbsim/hydro/buoyancy-lbs");
left.add("/fdm/jsbsim/hydro/planing-lift-lbs");
#left.add("/fdm/jsbsim/hydro/X/force-lbs");
#left.add("/fdm/jsbsim/hydro/Y/force-lbs");
left.add("/fdm/jsbsim/hydro/yaw-moment-lbsft");
left.add("/fdm/jsbsim/hydro/pitch-moment-lbsft");
left.add("/fdm/jsbsim/hydro/roll-moment-lbsft");
left.add("/fdm/jsbsim/hydro/planing/forebody-wetted-keel-ft");
left.add("/fdm/jsbsim/hydro/planing/middlebody-wetted-keel-ft");
left.add("/fdm/jsbsim/hydro/planing/afterbody-wetted-keel-ft");
left.add("/fdm/jsbsim/hydro/transverse-wave/wave-length-ft");
left.add("/fdm/jsbsim/hydro/transverse-wave/wave-amplitude-ft");
left.add("/fdm/jsbsim/hydro/transverse-wave/squat-ft");
left.add("/fdm/jsbsim/hydro/transverse-wave/pitch-trim-change-deg");
left.add("/fdm/jsbsim/hydro/environment/wave/relative-heading-rad");
left.add("/fdm/jsbsim/hydro/orientation/wave-pitch-trim-change-deg");
left.add("/fdm/jsbsim/hydro/orientation/wave-roll-trim-change-deg");
left.add("/fdm/jsbsim/hydro/environment/wave/angular-frequency-rad_sec");
left.add("/fdm/jsbsim/hydro/environment/wave/wave-number-rad_ft");
left.add("/fdm/jsbsim/hydro/environment/wave/level-fwd-ft");
left.add("/fdm/jsbsim/hydro/environment/wave/level-at-hrp-ft");
left.add("/fdm/jsbsim/hydro/environment/wave/level-aft-ft");


right.add("/orientation/heading-magnetic-deg");
right.add("/fdm/jsbsim/hydro/v-kt");
right.add("/fdm/jsbsim/hydro/vbx-fps");
right.add("/fdm/jsbsim/hydro/vby-fps");
right.add("/fdm/jsbsim/hydro/qbar-u-psf");
right.add("/fdm/jsbsim/hydro/Froude-number");
right.add("/fdm/jsbsim/hydro/speed-length-ratio");
right.add("/fdm/jsbsim/propulsion/engine[0]/engine-rpm");
right.add("/fdm/jsbsim/propulsion/engine[0]/power-hp");
right.add("/fdm/jsbsim/propulsion/engine[2]/engine-rpm");
right.add("/fdm/jsbsim/propulsion/engine[2]/power-hp");
right.add("/fdm/jsbsim/propulsion/propeller[0]/power-required-hp");
right.add("/fdm/jsbsim/propulsion/propeller[0]/thrust-lbs");
right.add("/fdm/jsbsim/propulsion/propeller[0]/advance-ratio");
right.add("/fdm/jsbsim/propulsion/engine[1]/engine-rpm");
right.add("/fdm/jsbsim/propulsion/engine[1]/power-hp");
right.add("/fdm/jsbsim/propulsion/engine[3]/engine-rpm");
right.add("/fdm/jsbsim/propulsion/engine[3]/power-hp");
right.add("/fdm/jsbsim/propulsion/propeller[1]/power-required-hp");
right.add("/fdm/jsbsim/propulsion/propeller[1]/thrust-lbs");
right.add("/fdm/jsbsim/propulsion/propeller[1]/advance-ratio");
#right.add("/fdm/jsbsim/");

###############################################################################
## Armament.
var torpedo =
    [props.globals.getNode("/controls/armament/station[0]/present"),
     props.globals.getNode("/controls/armament/station[1]/present")];
var trigger =
    [props.globals.getNode("/controls/armament/station[0]/release-all"),
     props.globals.getNode("/controls/armament/station[1]/release-all")];
var weight =
    [props.globals.getNode("/payload/weight[0]/weight-lb"),
     props.globals.getNode("/payload/weight[1]/weight-lb")];
var training_mode =
    props.globals.getNode("/controls/armament/training-mode");
var selected = 0;

controls.trigger = func(b) {
    #if (b) print("Armament trigger!");
    #debug.dump(torpedo);
    #debug.dump(trigger);
    #debug.dump(weight);
    #debug.dump(training_mode);
    if (b and training_mode.getValue()) {
        trigger[selected].setValue(1);
        return;
    }
    if (b and torpedo[selected].getValue()) {
        # Trigger pressed => launch torpedo.
        trigger[selected].setValue(1);
        torpedo[selected].setValue(0);
        weight[selected].setDoubleValue(0);
        return;
    }
    if (!b) {
        trigger[selected].setValue(0);
        selected = math.mod(selected + 1, 2);
        return;
    }
}
###############################################################################
