#!/bin/bash
EVENTS=1000
# ADD THIS FOR CRAB
# cat <<'EndOfTestFile' > produceFastSim16_sing.sh
# #!/bin/bash
export SCRAM_ARCH=slc6_amd64_gcc530

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_8_0_5_patch1/src ] ; then
  echo release CMSSW_8_0_5_patch1 already exists
else
  scram p CMSSW CMSSW_8_0_5_patch1
fi
cd CMSSW_8_0_5_patch1/src
eval `scram runtime -sh`

scram b
cd ../..
cmsDriver.py fragment_16.py --python_filename cfgs/SUS-RunIISpring16FSPremix-00004_1_cfg.py --eventcontent AODSIM --customise SimGeneral/DataMixingModule/customiseForPremixingInput.customiseForPreMixingInput,Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --fileout file:SUS-RunIISpring16FSPremix-00004.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIISpring16FSPremix-PUSpring16_80X_mcRun2_asymptotic_2016_v3-v1/GEN-SIM-DIGI-RAW" --conditions 80X_mcRun2_asymptotic_v12 --beamspot Realistic50ns13TeVCollision --customise_commands "process.source.numberEventsInLuminosityBlock = cms.untracked.uint32(200)" --step GEN,SIM,RECOBEFMIX,DIGIPREMIX_S2,DATAMIX,L1,DIGI2RAW,L1Reco,RECO,HLT:@fake1 --datamix PreMix --era Run2_25ns --fast --mc -n $EVENTS 
## ADD THIS FOR CRAB
##End of SUS-RunIISpring16FSPremix-00004_test.sh file
# EndOfTestFile

# # Make file executable
# chmod +x produceFastSim16_sing.sh

# if [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:amd64" ]; then
#   CONTAINER_NAME="slc6:amd64"
# elif [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:x86_64" ]; then
#   CONTAINER_NAME="slc6:x86_64"
# else
#   echo "Could not find amd64 or x86_64 for slc6"
#   exit 1
# fi
# export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
# singularity run -B /afs -B /cvmfs -B /etc/grid-security --no-home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/$CONTAINER_NAME $(echo $(pwd)/produceFastSim16_sing.sh)