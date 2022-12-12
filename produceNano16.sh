#!/bin/bash
cd /afs/cern.ch/cms/PPD/PdmV/work/McM/submit/SUS-RunIISummer16NanoAODv7-00821/

# Make voms proxy
voms-proxy-init --voms cms --out $(pwd)/voms_proxy.txt --hours 4
export X509_USER_PROXY=$(pwd)/voms_proxy.txt

# # Dump actual test code to a SUS-RunIISummer16NanoAODv7-00821_test.sh file that can be run in Singularity
# cat <<'EndOfTestFile' > SUS-RunIISummer16NanoAODv7-00821_test.sh
##!/bin/bash

export SCRAM_ARCH=slc6_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_2_22/src ] ; then
  echo release CMSSW_10_2_22 already exists
else
  scram p CMSSW CMSSW_10_2_22
fi
cd CMSSW_10_2_22/src
eval `scram runtime -sh`

scram b
cd ../..

# Maximum validation duration: 28800s
# Margin for validation duration: 30%
# Validation duration with margin: 28800 * (1 - 0.30) = 20160s
# Time per event for each sequence: 1.2000s
# Threads for each sequence: 2
# Time per event for single thread for each sequence: 2 * 1.2000s = 2.4000s
# Which adds up to 2.4000s per event
# Single core events that fit in validation duration: 20160s / 2.4000s = 8400
# Produced events limit in McM is 10000
# According to 1.0000 efficiency, validation should run 10000 / 1.0000 = 10000 events to reach the limit of 10000
# Take the minimum of 8400 and 10000, but more than 0 -> 8400
# It is estimated that this validation will produce: 8400 * 1.0000 = 8400 events
EVENTS=8400


# cmsDriver command
cmsDriver.py  --python_filename cfgs/SUS-RunIISummer16NanoAODv7-00821_1_cfg.py --eventcontent NANOAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier NANOAODSIM --fileout file:rootfiles/SUS-RunIISummer16NanoAODv7-00821.root --conditions 102X_mcRun2_asymptotic_v8 --step NANO --filein file:rootfiles/SUS-RunIISpring16MiniAODv2-00192.root --era Run2_2016,run2_nanoAOD_94X2016 --fast  --mc -n $EVENTS 

# # End of SUS-RunIISummer16NanoAODv7-00821_test.sh file
# EndOfTestFile

# # Make file executable
# chmod +x SUS-RunIISummer16NanoAODv7-00821_test.sh

# if [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:amd64" ]; then
#   CONTAINER_NAME="slc6:amd64"
# elif [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:x86_64" ]; then
#   CONTAINER_NAME="slc6:x86_64"
# else
#   echo "Could not find amd64 or x86_64 for slc6"
#   exit 1
# fi
# export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
# singularity run -B /afs -B /cvmfs -B /etc/grid-security --no-home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/$CONTAINER_NAME $(echo $(pwd)/SUS-RunIISummer16NanoAODv7-00821_test.sh)