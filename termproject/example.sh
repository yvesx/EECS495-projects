# generate corpora
#generate queries
# run tests
python generate.py -r 1000000  -c 2         -o int.1m.2.npy
python generate.py -r 100      -c 2         -o int.100.2.npy
python index.py -k 1 -e 0  -p 2 -q int.100.2.npy       -c int.1m.2.npy
python index_lsh.py             -q int.100.2.npy       -c int.1m.2.npy

python generate.py -r 100000   -c 4       -f -o float.100k.4.npy
python generate.py -r 100      -c 4       -f -o float.100.4.npy
python index.py -k 1 -e 0  -p 1 -q float.100.4.npy      -c float.100k.4.npy
python index_lsh.py             -q float.100.4.npy      -c float.100k.4.npy


python generate.py -r 10000000 -c 2       -f -o float.10m.2.npy
python generate.py -r 100 -c 2            -f -o float.100.2.npy
python index.py -k 1 -e 0  -p 2 -q float.100.2.npy      -c float.10m.2.npy
python index_lsh.py             -q float.100.2.npy      -c float.10m.2.npy


python generate.py -r 1000     -c 10      -g -o gaussian.1k.10.npy
python generate.py -r 100 -c 10           -g -o gaussian.100.10.npy
python index.py -k 1  -e 0  -p 1 -q gaussian.100.10.npy  -c gaussian.1k.10.npy
python index.py -k 10 -e 10 -p 1 -q gaussian.100.10.npy  -c gaussian.1k.10.npy
python index_lsh.py              -q gaussian.100.10.npy  -c gaussian.1k.10.npy


python generate.py -r 1000    -c 10000      -o int.1k.10k.npy
python generate.py -r 10      -c 10000      -o int.10.10k.npy
python index.py -k 1  -e 0  -p 1 -q int.10.10k.npy      -c int.1k.10k.npy
python index.py -k 10 -e 10 -p 1 -q int.10.10k.npy      -c int.1k.10k.npy
python index_lsh.py              -q int.10.10k.npy      -c int.1k.10k.npy

