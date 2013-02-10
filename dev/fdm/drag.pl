set datafile separator ","
set title  "Drag v.s. speed lenght ratio"
set ylabel "Force (lbf)"
set xlabel "Speed length ratio"
plot \
     "datalog.csv" using 148:158 title "Total drag (lbf)"\
    ,"datalog.csv" using 148:156 title "Displacement drag (lbf)"\
    ,"datalog.csv" using 148:157 title "Planing drag (lbf)"\
#    ,"datalog.csv" using 133:164 title "Total lift (lbf)"\
#    ,"datalog.csv" using 133:161 title "Buoyant lift (lbf)"\
#    ,"datalog.csv" using 133:162 title "Planing lift (lbf)"\
