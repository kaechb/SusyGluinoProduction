#!/bin/bash
EVENTS=1000

export SCRAM_ARCH=slc6_amd64_gcc630
source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_9_4_12/src ] ; then
  echo release CMSSW_9_4_12 already exists
else
  scram p CMSSW CMSSW_9_4_12
fi
cd CMSSW_9_4_12/src
eval `scram runtime -sh`

cd ../..
cmsDriver.py  --python_filename cfgs/SUS-RunIIFall17MiniAODv2-00263_1_cfg.py --eventcontent MINIAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier MINIAODSIM --fileout file:rootfiles/SUS-RunIIFall17MiniAODv2-00263.root --conditions 94X_mc2017_realistic_v15 --step PAT --scenario pp --filein file:rootfiles/SUS-RunIIFall17FSPremix-00033.root --era Run2_2017_FastSim,run2_miniAOD_94XFall17 --runUnscheduled --fast --mc -n $EVENTS 