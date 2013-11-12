# modify data in ikdt_config necessary.

python ikdt_index.py > ikdt_index_output &
SERVER_PID=$!
sleep 1
python mincemeat.py -p changeme -P 11230 localhost &
python mincemeat.py -p changeme -P 11231 localhost &
python mincemeat.py -p changeme -P 11232 localhost &
python mincemeat.py -p changeme -P 11233 localhost &
python mincemeat.py -p changeme -P 11234 localhost &
python mincemeat.py -p changeme -P 11235 localhost &
python mincemeat.py -p changeme -P 11236 localhost &
python mincemeat.py -p changeme -P 11237 localhost &
python mincemeat.py -p changeme -P 11238 localhost &
python mincemeat.py -p changeme -P 11239 localhost &
python mincemeat.py -p changeme -P 11240 localhost &
sleep 1
#kill $! 2>/dev/null
# make sure the program finishes.