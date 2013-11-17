OUTPUT=ikdt_index_output.py
python ikdt_index.py > $OUTPUT &
SERVER_PID=$!
# will get connection error for some workers
# because the job is so light that it finishes before the other workers can lauch.
sleep 1
python mincemeat.py -p ikdt localhost 
python mincemeat.py -p ikdt localhost 
python mincemeat.py -p ikdt localhost 
python mincemeat.py -p ikdt localhost 
sleep 1
kill $! 2>/dev/null
printf "tree = " | cat - $OUTPUT > /tmp/tempfile && mv /tmp/tempfile $OUTPUT; 
# make sure the program finishes.