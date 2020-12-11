SRC = $(wildcard nbs/*.ipynb)

build: $(SRC)
	#####################################
	#   BUILDING NOTEBOOKS IN ./nbs/    #
	#####################################
	nbdev_build_lib

test_fast:
	#####################################
	#   RUNNING TESTS                   #
	#####################################
	nbdev_test_nbs
    
test_integration:
	nbdev_test_nbs --flags 'slow integration' --timing true

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
	make test_integration
	make clean
	#####################################
	#    SHOWING GIT STATUS             #
	#####################################
	git status

