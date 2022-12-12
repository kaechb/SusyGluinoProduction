
#!/bin/bash

# IF CRAB
# cat <<'EndOfTestFile' > SUS-RunIISpring16MiniAODv2-00192_test.sh
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

# Maximum validation duration: 28800s
# Margin for validation duration: 30%
# Validation duration with margin: 28800 * (1 - 0.30) = 20160s
# Time per event for each sequence: 1.0000s
# Threads for each sequence: 1
# Time per event for single thread for each sequence: 1 * 1.0000s = 1.0000s
# Which adds up to 1.0000s per event
# Single core events that fit in validation duration: 20160s / 1.0000s = 20160
# Produced events limit in McM is 10000
# According to 1.0000 efficiency, validation should run 10000 / 1.0000 = 10000 events to reach the limit of 10000
# Take the minimum of 20160 and 10000, but more than 0 -> 10000
# It is estimated that this validation will produce: 10000 * 1.0000 = 10000 events
EVENTS=1000


# cmsDriver command
cmsDriver.py  --python_filename cfgs/SUS-RunIISpring16MiniAODv2-00192_1_cfg.py --eventcontent MINIAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier MINIAODSIM --fileout file:rootfiles/SUS-RunIISpring16MiniAODv2-00192.root --conditions 80X_mcRun2_asymptotic_2016_miniAODv2_v0 --step PAT --filein file:rootfiles/SUS-RunIISpring16FSPremix-00004.root --era Run2_25ns --runUnscheduled --fast  --mc -n $EVENTS 

# End of SUS-RunIISpring16MiniAODv2-00192_test.sh file
#EndOfTestFile

# # Make file executable
# chmod +x SUS-RunIISpring16MiniAODv2-00192_test.sh

# if [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:amd64" ]; then
#   CONTAINER_NAME="slc6:amd64"
# elif [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:x86_64" ]; then
#   CONTAINER_NAME="slc6:x86_64"
# else
#   echo "Could not find amd64 or x86_64 for slc6"
#   exit 1
# fi
# export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
# singularity run -B /afs -B /cvmfs -B /etc/grid-security --no-home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/$CONTAINER_NAME $(echo $(pwd)/SUS-RunIISpring16MiniAODv2-00192_test.sh)