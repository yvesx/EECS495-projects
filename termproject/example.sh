# generate corpora
python generate.py -r 1000    -c 100        -o int.1k.10.npy
python generate.py -r 100000  -c 1000    -f -o float.100k.1k.npy
python generate.py -r 1000000 -c 100     -g -o gaussian.1m.100.npy
python generate.py -r 1000    -c 10000      -o int.1k.10k.npy

#generate queries
python generate.py -r 100 -c 100        -o int.100.10.npy
python generate.py -r 100 -c 1000    -f -o float.100.1k.npy
python generate.py -r 100 -c 100     -g -o gaussian.100.100.npy
python generate.py -r 100 -c 10000      -o int.100.10k.npy

# run tests
python index.py -k 10 -e 0  -p 2 -q int.100.10.npy        -c int.1k.10.npy
python index.py -k 10 -e 0  -p 2 -q float.100.1k.npy      -c float.100k.1k.npy
python index.py -k 10 -e 0  -p 1 -q gaussian.100.100.npy  -c gaussian.1m.100.npy
python index.py -k 10 -e 0  -p 1 -q int.100.10k.npy       -c int.1k.10k.npy
python index.py -k 10 -e 10 -p 1 -q gaussian.100.100.npy  -c gaussian.1m.100.npy
python index.py -k 10 -e 10 -p 1 -q int.100.10k.npy       -c int.1k.10k.npy
