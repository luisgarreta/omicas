#!/bin/bash
echo "Javeriana MD profile..."

PATHDOCK=/home/lg/BIO/omicas/simulations/

MGLTOOLS_UTILS=$PATHDOCK/opt/MGLTools-1.5.7/MGLToolsPckgs/AutoDockTools/Utilities24
MGLTOOLS_BIN=$PATHDOCK/opt/MGLTools-1.5.7/bin
AUTODOCK=$PATHDOCK/opt/autodock
MEEKO=$PATHDOCK/opt/meeko
VINA=$PATHDOCK/opt/vina
WURLITZER=$PATHDOCK/opt/wurlitzer # To capture c++ output in notebooks
NAMD=/home/lg/repos/javerianaMD/soft/namd/NAMD_Git-2022-04-04_Linux-x86_64-multicore/


export PATH=$MGLTOOLS_UTILS:$MGLTOOLS_BIN:$AUTODOCK:$PATH:$MEEKO/bin:$NAMD

#export PYTHONPATH=/home/lg:$PATHDOCK/opt/pubchem:$PATHDOCK/opt/pymol:$MEEKO:$VINA:$WURLITZER
