#!/usr/bin/env bash

echo "Starting OP "

OP_PATH="simple_op/"
cd "${OP_PATH}"
python3 src/run.py settings.yaml.example -p 8000 -b http://honest-idp.com:8000 &
cd ..

echo "Starting RP"
RP_PATH="simple_rp/"
cd "${RP_PATH}"

python3 src/rp.py settings.yaml.example -p 8880 -b http://honest-sp.com:8880 &


# endless loop to keep the container up 
while true; do
  tail -f /dev/null & wait ${!}
done

echo "exited $0"
