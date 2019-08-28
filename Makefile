# Optional: change to the name of your assignment.  $(NAME).zip will be produced as output
NAME = assignment
# Path to zip if not in your $PATH
ZIP  = zip


SPECFILES = $(wildcard spec/*)
RUNFILES = run_autograder setup.sh

all: $(NAME).zip

$(NAME).zip: $(SPECFILES) $(RUNFILES)
	$(ZIP) 
