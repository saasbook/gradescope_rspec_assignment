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
	mkdir -p autograder/source autograder/results
	cp run_autograder autograder/
	chmod +x autograder/run_autograder
	cp setup.sh run_autograder rspec_gradescope_formatter.rb autograder/source
	cp -R spec autograder/source
	cp dummy.rb autograder/submission

.PHONY: clean
clean:
	rm -rf autograder
