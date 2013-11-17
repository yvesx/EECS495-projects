#!/bin/bash

# modify data in ikdt_config necessary.

OUTFTR=dkdt_chunk_ends.py
OUTIDX=dkdt_index_output.py
python dkdt_feature.py > $OUTFTR
printf "chunk_ends = " | cat - $OUTFTR > /tmp/tempfile && mv /tmp/tempfile $OUTFTR; 

python dkdt_index.py > $OUTIDX &
SERVER_PID=$!
sleep 1
python mincemeat.py -p dkdt localhost
sleep 1
kill $! 2>/dev/null
printf "tree = " | cat - $OUTIDX > /tmp/tempfile && mv /tmp/tempfile $OUTIDX; 
# make sure the program finishes.