#!/bin/bash
EVENTS=1000

export SCRAM_ARCH=slc6_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_2_11_patch1/src ] ; then
  echo release CMSSW_10_2_11_patch1 already exists
else
  scram p CMSSW CMSSW_10_2_11_patch1
fi
cd CMSSW_10_2_11_patch1/src
eval `scram runtime -sh`

scram b
cd ../..

cmsDriver.py  --python_filename cfgs/SUS-RunIIAutumn18MiniAOD-00115_1_cfg.py --eventcontent MINIAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier MINIAODSIM --fileout file:rootfiles/SUS-RunIIAutumn18MiniAOD-00115.root --conditions 102X_upgrade2018_realistic_v15 --step PAT --geometry DB:Extended --filein file:rootfiles/SUS-RunIIAutumn18FSPremix-00011.root --era Run2_2018 --fast --runUnscheduled --fast --mc -n $EVENTS 