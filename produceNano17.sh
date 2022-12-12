#!/bin/bash
EVENTS=1000

export SCRAM_ARCH=slc6_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_2_22/src ] ; then
  echo release CMSSW_10_2_22 already exists
else
  scram p CMSSW CMSSW_10_2_22
fi
cd CMSSW_10_2_22/src
eval `scram runtime -sh`

cd ../..


cmsDriver.py  --python_filename cfgs/SUS-RunIIFall17NanoAODv7-00342_1_cfg.py --eventcontent NANOAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier NANOAODSIM --fileout file:rootfiles/SUS-RunIIFall17NanoAODv7-00342.root --conditions 102X_mc2017_realistic_v8 --step NANO --filein file:rootfiles/SUS-RunIIFall17MiniAODv2-00263.root --era Run2_2017,run2_nanoAOD_94XMiniAODv2 --fast --mc -n $EVENTS