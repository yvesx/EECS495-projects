#!/usr/bin/env python
# index benchmark spatial data files using LSH.
# variations in row/instance, column/dimension, integer/float, distribution
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
import lsh
import optparse
import os
import sys
import types
import time

VERSION = "0.0.1"
# for different volumes of objects, K,L values are different.
# w isn't exactly 4 but the SIGMOD2012 LSH based on dynamic collision counting suggests 4
LSH_OPTIMAL_PARAMETERS = {
    100:{"K":14,"L":3,"w":4},
    1000:{"K":19,"L":4,"w":4},
    10000:{"K":25,"L":5,"w":4},
    100000:{"K":29,"L":6,"w":4},
    1000000:{"K":34,"L":8,"w":4},
    10000000:{"K":39,"L":10,"w":4},
    100000000:{"K":44,"L":14,"w":4}
}

def query_LSH(index,queries):
    qr,qc = queries.shape
    nn = []
    for i in xrange(qr):
        obj = np.array(queries[i],ndmin=2).T
        nn.append(index.Find(obj))
    return nn

def insert_LSH(index,corpus):
    cr,cc = corpus.shape
    for i in xrange(cr):
        obj = np.array(corpus[i],ndmin=2).T
        index.InsertIntoTable(np.random.randint(1<<62),obj)
    return index

if __name__ == '__main__':
    parser = optparse.OptionParser(usage="%prog [options]", version="%%prog %s"%VERSION)
    parser.add_option("-q", "--query", dest="query", help="query")
    parser.add_option("-c", "--corpus", dest="corpus", help="corpus")

    (options, args) = parser.parse_args()

    corpus = np.load(options.corpus,mmap_mode='r')
    cr,cc = corpus.shape
    queries = np.load(options.query,mmap_mode='r')
    qr,qc = queries.shape

    K = LSH_OPTIMAL_PARAMETERS[cr]["K"]
    L = LSH_OPTIMAL_PARAMETERS[cr]["L"]
    w = LSH_OPTIMAL_PARAMETERS[cr]["w"]

    lsh_index = lsh.index(w,K,L)
    
    tic= time.clock()#tic
    lsh_index = insert_LSH(lsh_index,corpus)
    t= time.clock() - tic
    print "Building index: %f seconds.." % (t) #toc: build time
    print "Building index: %f seconds per instance.." % (t/cr) #toc: build time
    print "Building index: %f seconds per scalar.." % (t/cr/cc) #toc: build time
    
    tic= time.clock()#tic
    nn = query_LSH(lsh_index,queries)
    t= time.clock() - tic
    print "Lookup index: %f seconds.." % (t) #toc: lookup time
    print "Lookup index: %f seconds per instance.." % (t/qr) #toc: lookup time
    print "Lookup index: %f seconds per scalar.." % (t/qr/qc) #toc: lookup time

