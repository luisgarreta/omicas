#!/usr/bin/python3

USAGE="
Create complex protein + ligand for a directory of ligands. \
And changes string 'UNL' to 'GEN G' in ligand \
USAGE: create-complexes-charmmguy.py <Protein> <Ligands dir>"

import os, sys
args = sys.argv

if (len (args) < 2):
    print (USAGE)
    sys.exit(0)

PROTEIN     = args[1]
LIGANDSDIR  = args[2]

protLines = open (PROTEIN).readlines ()

ligands = os.listdir (LIGANDSDIR)
print (ligands)
for n, LIGAND in enumerate (ligands):
    lname = LIGAND.split ("_")[0]
    lname = lname.replace ("conf", "conformation")
    ligPath = "%s/%s" % (LIGANDSDIR, LIGAND)
    ligLines  = open (ligPath).readlines()

    for i in range (len (ligLines)):
        if "ATOM" in ligLines[i][0:4]:
            ligLines[i] = ligLines[i][:21] + "L" + ligLines[i][22:]

    number = lname.split ("conformation")[1]
    complexPath = "complex%s.pdb" % (number)
    print (">>> ", complexPath)
    complexFile = open (complexPath, "w")
    complexFile.writelines (protLines)
    complexFile.writelines (ligLines)
    complexFile.close ()

    os.system ("mkdir %s" % lname)
    os.system ("cp %s/%s %s" % (LIGANDSDIR, LIGAND, lname)) 
    os.system ("cp %s %s" % (PROTEIN, lname)) 
    os.system ("mv %s %s" % (complexPath, lname)) 

