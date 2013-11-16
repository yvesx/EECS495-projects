#!/usr/bin/env python
# config file for kdt building
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
x, y = np.mgrid[0:5, 2:8]
data = zip(x.ravel(), y.ravel())
# The data source can be any dictionary-like object
corpus = dict(enumerate(data))
# {0: (0, 2), 1: (0, 3), 2: (0, 4), 3: (0, 5), 4: (0, 6), 5: (0, 7), 6: (1, 2), 7: (1, 3), 8: (1, 4), 9: (1, 5), 10: (1, 6), 11: (1, 7), 12: (2, 2), 13: (2, 3), 14: (2, 4), 15: (2, 5), 16: (2, 6), 17: (2, 7), 18: (3, 2), 19: (3, 3), 20: (3, 4), 21: (3, 5), 22: (3, 6), 23: (3, 7), 24: (4, 2), 25: (4, 3), 26: (4, 4), 27: (4, 5), 28: (4, 6), 29: (4, 7)}
queries = [[3.4, 4.1]]
M = 10 # number of machines, logically. actually the map reduce can be performed on any #machines<=M
dkdt_feature_samples = 10000
dkdt_S = 3 # similarity threshold. takes top 3 most similar branches in dkdt tree
def chunks(l, n):
    """ Yield successive n-sized chunks from l.
    """
    for i in xrange(0, len(l), n):
        yield l[i:i+n]

