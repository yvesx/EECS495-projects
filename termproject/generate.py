#!/usr/bin/env python
# generate benchmark spatial data files.
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
import optparse
import os
import random
import sys
import types

VERSION = "0.0.1"

def gen_int(r,c,rang):
	# random ints from 0 to rang-1
	return np.random.randint(rang, size=(r, c))

def gen_float(r,c,rang):
	# random floats from [0 to rang)
	return rang * np.random.random_sample(size=(r, c))

def gen_gaussian(r,c,rang):
	# random floats from multivariate gaussian. no fixed range
	data = np.random.random((r,c))
	mean = np.mean(data, axis = 0)
	cov = np.cov(data.T)
	return rang * np.random.multivariate_normal(mean, cov,(r,))

if __name__ == '__main__':
    parser = optparse.OptionParser(usage="%prog [options]", version="%%prog %s"%VERSION)
    parser.add_option("-r", "--instance", dest="r", type="int", help="instance")
    parser.add_option("-c", "--dimension", dest="c", type="int", help="dimension")
    parser.add_option("-o", "--output", dest="output", help="output")
    parser.add_option("-f", "--float", dest="float", action="store_true")
    parser.add_option("-g", "--gaussian", dest="gaussian", action="store_true")

    (options, args) = parser.parse_args()

    if options.gaussian:
    	# generate gaussian
        arr = gen_gaussian(options.r,options.c,4096)
        np.save(options.output,arr.astype('float32'))
    elif options.float:
        #generate uniform float data
        arr = gen_float(options.r,options.c,4096)
        np.save(options.output,arr.astype('float32'))
    else:
        #generate integer data
        arr = gen_int(options.r,options.c,4096)
        np.save(options.output,arr.astype('uint64'))



