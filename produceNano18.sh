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


cmsDriver.py  --python_filename cfgs/SUS-RunIIAutumn18NanoAODv7-00341_1_cfg.py  --eventcontent NANOAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier NANOAODSIM --fileout file:file:SUS-RunIIAutumn18NanoAODv7-00341.root --conditions 102X_upgrade2018_realistic_v21 --step NANO --filein file:rootfiles/SUS-RunIIAutumn18MiniAOD-00115.root --era Run2_2018,run2_nanoAOD_102Xv1 --fast --mc -n $EVENTS

# ONLX FOR CRABMake file executable
# chmod +x produceNano18.sh

# if [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:amd64" ]; then
#   CONTAINER_NAME="slc6:amd64"
# elif [ -e "/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/slc6:x86_64" ]; then
#   CONTAINER_NAME="slc6:x86_64"
# else
#   echo "Could not find amd64 or x86_64 for slc6"
#   exit 1
# fi
# export SINGULARITY_CACHEDIR="/tmp/$(whoami)/singularity"
# singularity run -B /afs -B /cvmfs -B /etc/grid-security --no-home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/cmssw/$CONTAINER_NAME $(echo $(pwd)/produceNano18.sh)