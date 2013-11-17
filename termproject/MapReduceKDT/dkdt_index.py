#!/usr/bin/env python
# building feature interleaver for distributed kdkd tree.
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

import mincemeat

def mapfn(k, v):
    import kdt_config # import has to be under function. cf. mincemeat README.
    from dkdt_chunk_ends import chunk_ends
    from scipy.spatial.distance import hamming
    import numpy as np
    sims = [( hamming(np.asarray(chunk),np.asarray(v)) , i ) for i,chunk in enumerate(chunk_ends)]
    sims = sorted(sims)
    yield sims[-1][1],v # yield one pair so each record is indexed at only one leaf tree.


def reducefn(k, vs):
    from scipy.spatial import kdtree
    import cPickle
    # patch module-level attribute to enable pickle to work
    kdtree.node      = kdtree.KDTree.node
    kdtree.leafnode  = kdtree.KDTree.leafnode
    kdtree.innernode = kdtree.KDTree.innernode

    kdtree = kdtree.KDTree(vs,leafsize=10)
    raw = cPickle.dumps(kdtree) # string
    return raw

import kdt_config
s = mincemeat.Server()
s.datasource = kdt_config.corpus
s.mapfn = mapfn
s.reducefn = reducefn

results = s.run_server(password="dkdt")
print results
