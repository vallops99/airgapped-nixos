# Create a NixOS ISO #
This is a very simple flake used to create an ISO image of NixOS with sparrow package already installed in it.   

## How to use it ##
Insert a USB stick into you pc.   
Find the name of your stick with: `lsblk -p -o NAME,VENDOR,MODEL,SIZE,TYPE,SERIAL`   
Replace the string `/dev/sda` in `build_and_deploy.sh` with the name of your stick
Run `./build_and_deploy.sh`
