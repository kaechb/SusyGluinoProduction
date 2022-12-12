
This repo is for producing fastsim MC for T5qqqVV
Note that if you want to change the chargino masses you need to modify the fragments.
For now only tested locally for 2017
To produce stuff locally:

1. `sing`, this starts singularity
2. `source .singrc`, sets some env variables and goes to Dust
3. `cd SusyProduction`, this is the git directory
4. `source produceFastSim17.sh`, this runs the Fastsim steps
5. `source produceMini17.sh`,a this runs the miniaAOD
6. exit singularity and repeat 1-3
7. `produceNano17.sh`
this produces Nano from the miniAOD
These Nano samples can be inspected by TBrowser to see whether different masses are explorred - check for the model, mglu,mnlsp, mlsp branch