#!/home/lg/.bin/xvmd

# Calculate of entire protein
# RMSD of trajectory frames: from frame0 to frames N
#
set PSF  [lindex $argv 0]
set DCD  [lindex $argv 1]
set NAME [lindex $argv 2]

#set n [llength lindex]
set outName "rmsd.dat" 
if {$NAME ne ""} then {
	set outName $NAME
}

mol new $PSF type {psf} first 0 last -1 step 1 waitfor 1
mol addfile $DCD type {dcd} first 0 last -1 step 1 waitfor -1 0

puts [printf "Writing RMSDs into file: %s" $outName]
set outfile [open $outName w]
set nf [molinfo top get numframes]
puts [printf "NF: %d " $nf]
set frame0 [atomselect top "protein and backbone and noh" frame 0]
set sel [atomselect top "protein and backbone and noh"]
# rmsd calculation loop
for { set i 1 } { $i <= $nf } { incr i } {
	$sel frame $i
	$sel move [measure fit $sel $frame0]
	puts $outfile "[measure rmsd $sel $frame0]"
}
close $outfile
exit

