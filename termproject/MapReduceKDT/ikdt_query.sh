#!/bin/bash

# modify data in ikdt_config necessary.

OUTPUT=ikdt_query_output.py
python ikdt_query.py > $OUTPUT &
SERVER_PID=$!
sleep 1
python mincemeat.py -p ikdt localhost
python mincemeat.py -p ikdt localhost
python mincemeat.py -p ikdt localhost
sleep 1
kill $! 2>/dev/null
printf "output = " | cat - $OUTPUT > /tmp/tempfile && mv /tmp/tempfile $OUTPUT; 
# make sure the program finishes.