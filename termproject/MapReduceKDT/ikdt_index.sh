#!/bin/bash

# modify data in ikdt_config necessary.

OUTPUT=ikdt_index_output.py
python ikdt_index.py > $OUTPUT &
SERVER_PID=$!
sleep 1
python mincemeat.py -p ikdt -P 11230 localhost &
python mincemeat.py -p ikdt -P 11231 localhost &
python mincemeat.py -p ikdt -P 11232 localhost &
python mincemeat.py -p ikdt -P 11233 localhost &
python mincemeat.py -p ikdt -P 11234 localhost &
sleep 1
kill $! 2>/dev/null
printf "tree = " | cat - $OUTPUT > /tmp/tempfile && mv /tmp/tempfile $OUTPUT; 
# make sure the program finishes.