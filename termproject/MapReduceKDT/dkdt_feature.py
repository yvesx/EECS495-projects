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


def getTopTreeLeaves():
    import random
    import kdt_config
    sample_size = min(kdt_config.dkdt_feature_samples,len(kdt_config.corpus))
    datasource = sorted(random.sample(kdt_config.corpus,sample_size)) # building feature interleaving by samples

    chunks = kdt_config.chunks(datasource,int(len(datasource)/kdt_config.M)+1 )
    chunk_ends = [x[0] for x in chunks] # only keep the end figure for comparisons
    return chunk_ends
    #
    #
    # option 2 is to put them into M clusters.

if __name__ == '__main__':
    print getTopTreeLeaves()