Kloud Kd Tree (KdKdT)
=================================

Introduction
------------
Kloud Kd Tree implements Kd Tree in a map reduce framework. Details are in [this](http://www.vision.caltech.edu/malaa/publications/aly11distributed.pdf) paper.

Two implementations
-------------------

* Independent Kd Trees

* Distributed Kd Trees

Index operations
----------------

* Run `./ikdt_index.sh` or `./dkdt_index.sh`

* Index trees are stored in `ikdt_index_output.py` as a python variable.

Query operations
----------------

* Run `./ikdt_query.sh` or `./dkdt_query.sh`

* Output stored in `ikdt_query_output.py` as a python variable.