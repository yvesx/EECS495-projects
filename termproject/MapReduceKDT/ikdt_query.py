#!/usr/bin/env python
# building independent, parallel kd trees on map reduce
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
    from scipy.spatial import kdtree
    kdtree.node      = kdtree.KDTree.node
    kdtree.leafnode  = kdtree.KDTree.leafnode
    kdtree.innernode = kdtree.KDTree.innernode
    #k is 0, ..., M
    #v is serialzied KDtree
    import kdt_config # import has to be under function. cf. mincemeat README.
    import cPickle
    ikdt = cPickle.loads(v)
    for i , q in enumerate(kdt_config.queries):
        nearestNeighbors = ikdt.query(q)
        yield i , nearestNeighbors

def reducefn(k, vs):
    allNearestNeighbors = [j for i in vs for j in i] # basically flattern the list
    # add sorting and cropping here if necessary.
    return allNearestNeighbors
import kdt_config
s = mincemeat.Server()
import ikdt_index_output
s.datasource = ikdt_index_output.tree # not queries, but KDTrees are NOT datasource.
s.mapfn = mapfn
s.reducefn = reducefn

results = s.run_server(password="ikdt")
print results
