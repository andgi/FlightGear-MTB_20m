###############################################################################
##
## Swedish Navy 20m-class motor torpedo boat for FlightGear.
##
##  Copyright (C) 2012 - 2025  Anders Gidenstam  (anders(at)gidenstam.org)
##  This file is licensed under the GPL license v2 or later.
##
###############################################################################

###############################################################################
# Walk views.

# Deck
var deckConstraint = walkview.makeUnionConstraint
   (
    [
     # Bridge area.
     walkview.SlopingYAlignedPlane.new([ 9.40, -1.10, 0.28],
                                       [11.00,  1.10, 0.22]),
     # The areas port and starboard of the engine compartment.
     walkview.SlopingYAlignedPlane.new([11.00, -1.00, 0.22],
                                       [12.70, -0.55, 0.18]),
     walkview.SlopingYAlignedPlane.new([12.70, -0.80, 0.18],
                                       [13.70, -0.55, 0.10]),
     walkview.SlopingYAlignedPlane.new([11.00,  0.55, 0.22],
                                       [12.70,  1.00, 0.18]),
     walkview.SlopingYAlignedPlane.new([12.70,  0.55, 0.18],
                                       [13.70,  0.80, 0.10]),
     # The area aft of the engine companion.
     walkview.SlopingYAlignedPlane.new([13.70, -0.70, 0.10],
                                       [14.60,  0.70, 0.08]),
    ]);

# ThreeDModel manager.
#   Moves a 3d model representing the crew member together with the view.
#   The position is in the main 3d coordinate system.
# CONSTRUCTOR:
#       3dModel.new(name, maximumMoveValue);
#
#         name             ... Name of the view : string
#         maximumMoveValue ... Maximum movement of the view i meters : double
#
var ThreeDModelManager = {
    new : func (name, maximumMoveValue) {
        var base = props.globals.getNode("crew/" ~ name ~ "/");
        var prefix  = "position-";
        var postfix = "-m";
        var obj = { parents : [ThreeDModelManager] };
        obj.pos_m =
            [
             base.getNode(prefix ~ "X" ~ postfix),
             base.getNode(prefix ~ "Y" ~ postfix),
             base.getNode(prefix ~ "Z" ~ postfix)
            ];
        obj.maximumMoveValue = maximumMoveValue;
        base.getNode("maximum-move-m").setValue(obj.maximumMoveValue);
        postfix = "-norm";
        obj.pos_norm =
            [
             base.getNode(prefix ~ "X" ~ postfix),
             base.getNode(prefix ~ "Y" ~ postfix),
             base.getNode(prefix ~ "Z" ~ postfix)
            ];
        postfix = "-offset-deg";
        obj.orientation_deg =
            [
             base.getNode("heading" ~ postfix),
             base.getNode("pitch" ~ postfix),
            ];
        return obj;
    },
    update : func (walker) {
        # Position.
        var pos = walker.get_pos();
        me.pos_m[0].setValue(pos[0]);
        me.pos_m[1].setValue(pos[1]);
        me.pos_m[2].setValue(pos[2] - walker.get_eye_height());
        # Normalized position.
        me.pos_norm[0].setValue(pos[0]/me.maximumMoveValue);
        me.pos_norm[1].setValue(pos[1]/me.maximumMoveValue);
        me.pos_norm[2].setValue((pos[2] - walker.get_eye_height())/me.maximumMoveValue);
        # Orientation is not yet stored in the walker but is stored in the view.
        me.orientation_deg[0].setValue(
            props.globals.getNode("/sim/current-view/heading-offset-deg").getValue());
        me.orientation_deg[1].setValue(
            props.globals.getNode("/sim/current-view/pitch-offset-deg").getValue());
    }
};

# Create the view managers.
var deck_walker =
        walkview.Walker.new("Deck View",
                            deckConstraint,
                            [ThreeDModelManager.new("deck-view", 20.0)]);
#                            [walkview.JSBSimPointmass.new(29)]);

deck_walker.set_eye_height(1.70);

###############################################################################
