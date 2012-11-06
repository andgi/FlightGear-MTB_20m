###############################################################################
##
## Swedish Navy 20m-class motor torpedo boat for FlightGear.
##
##  Copyright (C) 2012  Anders Gidenstam  (anders(at)gidenstam.org)
##  This file is licensed under the GPL license v2 or later.
##
###############################################################################

###############################################################################
# Walk views.

# Deck
var deckConstraint = walkview.makeUnionConstraint
   (
    [
     walkview.SlopingYAlignedPlane.new([ 9.60, -1.00, 0.20],
                                       [13.00,  1.00, 0.10]),
     walkview.SlopingYAlignedPlane.new([13.00, -0.70, 0.10],
                                       [14.80,  0.70, 0.04]),
    ]); 

# Create the view managers.
var deck_walker =
        walkview.Walker.new("Deck View",
                            deckConstraint);
#                            [walkview.JSBSimPointmass.new(29)]);

deck_walker.set_eye_height(1.70);

###############################################################################
