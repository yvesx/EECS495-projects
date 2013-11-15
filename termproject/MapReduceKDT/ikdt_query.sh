#!/bin/bash

# modify data in ikdt_config necessary.

OUTPUT=ikdt_query_output.py
python ikdt_query.py > ikdt_query_output.py &
SERVER_PID=$!
sleep 1
python mincemeat.py -p changeme -P 11230 localhost 2>/dev/null&
python mincemeat.py -p changeme -P 11231 localhost 2>/dev/null&
python mincemeat.py -p changeme -P 11232 localhost 2>/dev/null&
python mincemeat.py -p changeme -P 11233 localhost 2>/dev/null&
python mincemeat.py -p changeme -P 11234 localhost 2>/dev/null&
sleep 1
kill $! 2>/dev/null
printf "output = " | cat - $OUTPUT > /tmp/tempfile && mv /tmp/tempfile $OUTPUT; 
# make sure the program finishes.