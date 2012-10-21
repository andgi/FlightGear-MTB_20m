#!/bin/bash
# Copyright (C) 2012  Anders Gidenstam  (anders(at)gidenstam.org)
# This file is licensed under the GPL license version 2 or later.
#
# Usage: create_experiment.sh <base dir> <name base>

#export PATH=$PATH:$HOME/FlightGear/gerris/bin

BASEDIR=$1
BASE=$2

# Hydrodynamic reference point [m].
HRPX=12.0
HRPZ=0.0

# Water level below the HRP [m].
#HAGL=1.2192 # 4ft
#HAGL=1.524  # 5ft
#HAGL=1.8288 # 6ft
HAGL=2.1336 # 7ft

# Compute actual model offsets.
XOFFSET=`echo -$HRPX | bc`
ZOFFSET=`echo $HAGL-$HRPZ | bc`

#echo $ZOFFSET
#exit

if [ ! -d ${BASEDIR} ]
then
  mkdir ${BASEDIR}
fi
cd ${BASEDIR}

for roll in -4 -2 0 2 4; do
  for pitch in -8 -4 -2 0 2 4 8; do
    dir=${BASE}_r${roll}_p${pitch}
    mkdir ${dir}
    transform --tx=$XOFFSET --tz=$ZOFFSET < ../MTB_20m.gts.base | transform --ry ${pitch} | transform --rx ${roll} -v > ${dir}/MTB_20m.gts

    (cd ${dir}; ln -s ../../buoyancy3D.gfs . )
  done;
done;
