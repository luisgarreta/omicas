#!/home/lg/.bin/xvmd
# Get frame from trajectory
#
puts "-----------------------------------------------------------------------------------------------"
set USAGE "md-dcd-get-frame.tcl <PSF file> <DCD trajectory> \[Frame number\] \[all|protein|protein-noH]"
puts "-----------------------------------------------------------------------------------------------"

set PSF  [lindex $argv 0];
set DCD  [lindex $argv 1];
set nFRAME [lindex $argv 2];
set SELECTION [lindex $argv 3];   

set OUTNAME "f.pdb";

if {$PSF eq "" || $DCD eq ""} then {
	puts $USAGE
	exit
}

mol new $PSF type {psf} first 0 last -1 step 1 waitfor 1
mol addfile $DCD type {dcd} first 0 last -1 step 1 waitfor -1 0

if {$nFRAME eq ""} then {
	puts [format ">>> %s " [molinfo top get numframes]];
	exit
}

switch $SELECTION {
	"protein" {
		set SELECTION "protein";
		set OUTNAME [format "f%d-protH.pdb" $nFRAME];
	}
	"protein-noH" {
		set SELECTION "protein and backbone and noh";
		set OUTNAME [format "f%d-protNoH.pdb" $nFRAME];
	}
	"all" {
		set SELECTION "all";
		set OUTNAME [format "f%d-all.pdb" $nFRAME];
	}
}
puts [format ">>> SELECTION: %s" $SELECTION]
#if {$SELECTION eq "protein"} then {
#	set SELECTION "protein and backbone and noh";
#}



#set frame0 [atomselect top "protein and backbone and noh" frame $nFRAME]
set frame0 [atomselect top $SELECTION frame $nFRAME]
$frame0 writepdb $OUTNAME
exit

