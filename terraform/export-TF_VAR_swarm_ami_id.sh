#!/bin/bash
export TF_VAR_swarm_ami_id=$(\
   grep 'artifact,0,id' \
   packer-ubuntu-docker.log \
   | cut -d, -f6 | cut -d: -f2)

echo TF_VAR_swarm_ami_id => $TF_VAR_swarm_ami_id
