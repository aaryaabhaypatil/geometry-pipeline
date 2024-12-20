# Makefile for Geometry Pipeline
CC=gcc
CFLAGS=-O2 -Wall -Werror -Wno-unused-result -std=c99
LDFLAGS=-lm
SEARCHER_SOURCE=smallest_triangle.c
SEARCHER_BINARY=smallest_triangle

# non dependency commands for this Makefile
.PHONY: build
.PHONY: generator
.PHONY: searcher
.PHONY: sample
.PHONY: test
.PHONY: clean

# default rule
build: generator searcher
	# commands that are needed to build both your program (no execution)
	gcc smallest_triangle.c -o smallest_triangle -lm

generator: 
	# commands to build the Generator program (no execution)
	# use only a single file: GenPoints.java or gen_points.py
	python3 gen_points.py -N=3 -mindist=2 -rseed=3

searcher: ${SEARCHER_SOURCE}
	# commands to build the Searcher program
	# use only a single file: smallest_triangle.c
	${CC} ${CFLAGS} ${SEARCHER_SOURCE} -o ${SEARCHER_BINARY} ${LDFLAGS}

sample:
	# execute Generator program with arguments N=20 mindist=2 rseed=3 and pipe the result to Searcher program
	python3 gen_points.py -N=20 -mindist=2 -rseed=3 | ./smallest_triangle -lm

test:
	# execute all tests
	#  Generator self test - with argsets
	#  Searcher self test
	#  Generator and Searcher end to end tests - with argsets
	# using a test.sh script (any supported scrip ting language on Ed) is encouraged
	chmod u+x test.sh
	./test.sh 

clean:
	# delete any unwanted build or editing files (not your source files!)
	rm smallest_triangle

