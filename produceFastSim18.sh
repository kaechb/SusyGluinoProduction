#!/bin/bash
# ADD no_exec if CARB!!!!
#SUS-RunIIAutumn18FSPremix-00011
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

cmsDriver.py Configuration/GenProduction/python/fragment_18.py --python_filename cfgs/SUS-RunIIAutumn18FSPremix-00011_1_cfg.py --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --fileout file:rootfiles/SUS-RunIIAutumn18FSPremix-00011.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIIFall17FSPrePremix-PUMoriond18_102X_upgrade2018_realistic_v15-v2/GEN-SIM-DIGI-RAW" --conditions 102X_upgrade2018_realistic_v15 --beamspot Realistic25ns13TeVEarly2018Collision --customise_commands "process.source.numberEventsInLuminosityBlock = cms.untracked.uint32(200)" --step GEN,SIM,RECOBEFMIX,DIGI,DATAMIX,L1,DIGI2RAW,L1Reco,RECO --procModifiers premix_stage2 --datamix PreMix --era Run2_2018_FastSim --fast --mc -n $EVENTS 

chmod +x produceFastSim18.sh
# #if crab
# if [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:amd64" ]; then
#   CONTAINER_NAME="slc6:amd64"
# elif [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:x86_64" ]; then
#   CONTAINER_NAME="slc6:x86_64"
# else
#   echo "Could not find amd64 or x86_64 for slc6"
#   exit 1
# fi
# export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
# singularity run -B /afs -B /cvmfs -B /etc/grid-security --no-home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/$CONTAINER_NAME $(echo $(pwd)/produceFastSim18.sh)