# Optional: change to the name of your assignment.  $(NAME).zip will be produced as output
NAME = assignment
# Path to zip if not in your $PATH
ZIP  = zip


FILES = $(wildcard spec/*) run_autograder setup.sh

all: $(NAME).zip

$(NAME).zip: $(FILES)
	$(ZIP) 

.phony: localtest
localtest: $(FILES)
	mkdir -p autograder/source autograder/results
	cp run_autograder autograder/
	cp rspec_gradescope_formatter.rb autograder/source
	cd autograder && ./run_autograder

clean:
	rm -rf autograder
