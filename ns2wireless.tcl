Basic Wireless NS2 Simulation
# ==============================

# Create simulator
set ns [new Simulator]

# Define output trace files
set tracefile [open out.tr w]
set namfile [open out.nam w]
$ns trace-all $tracefile
$ns namtrace-all-wireless $namfile 500 500    ;# 500x500 area

# Define topology size
set val(x) 500
set val(y) 500

# Create a topology object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Define the general operation parameters
set chan_1_ [new Channel/WirelessChannel]

# Define physical, link, and MAC layers
Phy/WirelessPhy set CPThresh_ 10.0
Phy/WirelessPhy set CSThresh_ 1.0e-9
Phy/WirelessPhy set RXThresh_ 1.0e-9
Phy/WirelessPhy set Pt_ 0.2818
Phy/WirelessPhy set freq_ 2.472e9
Phy/WirelessPhy set L_ 1.0

Mac/802_11 set dataRate_ 1Mb
Mac/802_11 set basicRate_ 1Mb

# Create node configuration
$ns node-config -adhocRouting DSDV \
                -llType LL \
                -macType Mac/802_11 \
                -ifqType Queue/DropTail/PriQueue \
                -ifqLen 50 \
                -antType Antenna/OmniAntenna \
                -propType Propagation/TwoRayGround \
                -phyType Phy/WirelessPhy \
                -channel $chan_1_ \
                -topoInstance $topo \
                -agentTrace ON \
                -routerTrace ON \
                -macTrace ON

# Create nodes
set n0 [$ns node]
set n1 [$ns node]

# Initial positions (X Y Z)
$n0 set X_ 100.0
$n0 set Y_ 200.0
$n0 set Z_ 0.0

$n1 set X_ 400.0
$n1 set Y_ 200.0
$n1 set Z_ 0.0

# Define color for NAM
$ns color 1 Blue

# Create UDP and Null agents
set udp0 [new Agent/UDP]
$udp0 set class_ 1
$ns attach-agent $n0 $udp0

set null0 [new Agent/Null]
$ns attach-agent $n1 $null0
$ns connect $udp0 $null0

# Create CBR traffic
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

# Schedule traffic
$ns at 1.0 "$cbr0 start"
$ns at 4.0 "$cbr0 stop"

# Optional: add node movement
$ns at 0.5 "$n0 setdest 400.0 200.0 10.0"
$ns at 3.5 "$n1 setdest 100.0 200.0 5.0"

# Define finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Call finish
$ns at 5.0 "finish"

# Run simulation
$ns run

sudo apt update
sudo apt install ns2 nam
sudo apt install tcl
sudo apt install tk

ns ns2wireless.tcl
nam out.nam
