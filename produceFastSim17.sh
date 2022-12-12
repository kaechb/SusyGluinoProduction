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
mkdir -p Configuration/GenProduction/python
cp ../../fragment_17.py Configuration/GenProduction/python
eval `scram runtime -sh`

scram b
cd ../..

cmsDriver.py Configuration/GenProduction/python/fragment_17.py --python_filename cfgs/SUS-RunIIFall17FSPremix-00033_1_cfg.py --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --fileout file:rootfiles/SUS-RunIIFall17FSPremix-00033.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIIFall17FSPrePremix-PUMoriond17_94X_mc2017_realistic_v15-v1/GEN-SIM-DIGI-RAW" --conditions 94X_mc2017_realistic_v15 --beamspot Realistic25ns13TeVEarly2017Collision --customise_commands "process.source.numberEventsInLuminosityBlock = cms.untracked.uint32(200)" --step GEN,SIM,RECOBEFMIX,DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,L1Reco,RECO --datamix PreMix --era Run2_2017_FastSim --fast --mc -n $EVENTS 