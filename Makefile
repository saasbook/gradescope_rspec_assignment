# @see https://gradescope-autograders.readthedocs.io/en/latest/specs/
# Optional: change to the name of your assignment.  $(NAME).zip will be produced as output
NAME = assignment
# Path to zip if not in your $PATH
ZIP  = zip


FILES = $(wildcard spec/*) run_autograder setup.sh

all: $(NAME).zip

$(NAME).zip: $(FILES)
	$(ZIP) 

.PHONY: localtest
localtest: make_localenv
	cd autograder && ./run_autograder

.PHONY: make_localenv
make_localenv: $(FILES)
	@echo 'Setting up environment to look like Gradescope docker container...'
	-rm -rf autograder
	mkdir autograder && cd autograder && mkdir source submission
	cp run_autograder autograder/
	cp -R Makefile README.md dummy.rb rspec_gradescope_formatter.rb run_autograder setup.sh spec/ autograder/source
	cp dummy.rb autograder/submission/
	echo 'Grading dummy assignment with run_autograder...'
	cd autograder && ./run_autograder
	echo 'Done, check autograder/results/results.json for results'

.PHONY: clean
clean:
	rm -rf autograder
