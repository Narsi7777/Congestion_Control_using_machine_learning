# Define simulator
set ns [new Simulator]

# Get input parameters from command-line arguments
if {[llength $argv] < 5} {
    puts "Error: Insufficient arguments! Usage: ns congestion.tcl <num_nodes> <x_dim> <y_dim> <packet_size> <rate>"
    exit 1
}

set val(nn) [lindex $argv 0]  ;# Number of nodes
set val(x) [lindex $argv 1]   ;# X dimension
set val(y) [lindex $argv 2]   ;# Y dimension
set packetSize_ [lindex $argv 3]
set rate_ [lindex $argv 4]

# Validate if nn is set
if {$val(nn) == "" || $val(nn) < 2} {
    puts "Error: val(nn) must be at least 2."
    exit 1
}

# Define trace and NAM files
set tracefile [open congestion.tr w]
$ns trace-all $tracefile
set namfile [open congestion.nam w]
$ns namtrace-all $namfile

# Create Topography object
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

# Create God object
create-god $val(nn)

# Node Configuration
$ns node-config -adhocRouting AODV \
            -llType LL \
            -macType Mac/802_11 \
            -ifqType Queue/DropTail \
            -ifqLen 100 \
            -antType Antenna/OmniAntenna \
            -propType Propagation/TwoRayGround \
            -phyType Phy/WirelessPhy \
            -channel [new Channel/WirelessChannel] \
            -topoInstance $topo \
            -agentTrace ON \
            -routerTrace ON \
            -macTrace ON

# Create nodes
for {set i 0} {$i < $val(nn)} {incr i} {
set node($i) [$ns node]
$node($i) random-motion 0
$node($i) set X_ [expr {rand()*$val(x)}]
$node($i) set Y_ [expr {rand()*$val(y)}]
$node($i) set Z_ 0.0
}

# Define mobility
proc set-mobility {node speed} {
set destX [expr {rand()*500}]
set destY [expr {rand()*500}]
$node setdest $destX $destY $speed
}

for {set i 0} {$i < $val(nn)} {incr i} {
set-mobility $node($i) 3.5
}

# Add congestion-causing traffic
for {set i 0} {$i < [expr {int($val(nn) / 2)}]} {incr i} {
set udp($i) [new Agent/UDP]
set null($i) [new Agent/Null]

$ns attach-agent $node($i) $udp($i)
$ns attach-agent $node([expr {$i + int($val(nn) / 2)}]) $null($i)
$ns connect $udp($i) $null($i)

set cbr($i) [new Application/Traffic/CBR]
$cbr($i) attach-agent $udp($i)
$cbr($i) set packetSize_ $packetSize_
$cbr($i) set rate_ $rate_
$cbr($i) set random_ false
$ns at 10.0 "$cbr($i) start"
$ns at 490.0 "$cbr($i) stop"
}

# Run simulation
$ns at 100.0 "finish"
proc finish {} {
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exit 0
}
$ns run
