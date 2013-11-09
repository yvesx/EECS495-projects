#!/usr/bin/env python
# index benchmark spatial data files.
# variations in row/instance, column/dimension, integer/float, distribution
# python index.py -k 10 -e 0  -p 2 -q int.100.10.npy        -c int.1k.10.npy
# python index.py -k 10 -e 0  -p 2 -q float.100.1k.npy      -c float.100k.1k.npy
# python index.py -k 10 -e 0  -p 1 -q gaussian.100.100.npy  -c gaussian.1m.100.npy
# python index.py -k 10 -e 0  -p 1 -q int.100.10k.npy       -c int.1k.10k.npy
# python index.py -k 10 -e 10 -p 1 -q gaussian.100.100.npy  -c gaussian.1m.100.npy
# python index.py -k 10 -e 10 -p 1 -q int.100.10k.npy       -c int.1k.10k.npy
################################################################################
# Copyright (c) 2013 yves xie
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
################################################################################

import numpy as np
import optparse
import os
from scipy import spatial
import sys
import types
import time

VERSION = "0.0.1"

if __name__ == '__main__':
    parser = optparse.OptionParser(usage="%prog [options]", version="%%prog %s"%VERSION)
    parser.add_option("-k", "--topK", dest="k", type="int", help="topK")
    parser.add_option("-e", "--epsilon", dest="epsilon", type="float", help="epsilon")
    parser.add_option("-p", "--LpNorm", dest="p", type="float", help="LpNorm")
    parser.add_option("-q", "--query", dest="query", help="query")
    parser.add_option("-c", "--corpus", dest="corpus", help="corpus")

    (options, args) = parser.parse_args()
    corpus = np.load(options.corpus,mmap_mode='r')
    cr,cc = corpus.shape
    queries = np.load(options.query,mmap_mode='r')
    qr,qc = queries.shape
    tic= time.clock()#tic
    kdtree = spatial.KDTree(corpus,leafsize=10)
    t= time.clock() - tic
    print "Building index: %f seconds.." % (t) #toc: build time
    print "Building index: %f seconds per instance.." % (t/cr) #toc: build time
    print "Building index: %f seconds per scalar.." % (t/cr/cc) #toc: build time
    
    tic= time.clock()#tic
    nn = kdtree.query(x=queries,eps=options.epsilon,p=options.p)
    t= time.clock() - tic
    print "Lookup index: %f seconds.." % (t) #toc: lookup time
    print "Lookup index: %f seconds per instance.." % (t/qr) #toc: lookup time
    print "Lookup index: %f seconds per scalar.." % (t/qr/qc) #toc: lookup time

