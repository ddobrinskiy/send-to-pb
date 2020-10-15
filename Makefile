SRC = $(wildcard nbs/*.ipynb)

build: $(SRC)
	#####################################
	#   BUILDING NOTEBOOKS IN ./nbs/    #
	#####################################
	nbdev_build_lib

test:
	#####################################
	#   RUNNING TESTS                   #
	#####################################
	nbdev_test_nbs --timing true
    
test_slow:
	nbdev_test_nbs --flags 'slow|integration' --timing true 

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

# editable install
pip_install:
	pip install -e .

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist
	nbdev_clean_nbs

all:
	make build
	make test
	make clean
	#####################################
	#    SHOWING GIT STATUS             #
	#####################################
	git status

