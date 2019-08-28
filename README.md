# RSpec With Gradescope

To create a Gradescope-compatible autograder for a programming
assignment that is graded entirely on the basis of RSpec tests,
structure the homework solutions repo as follows.

Note: It's fine if the assignment is split into multiple
specfiles, and/or if the students submit multiple files, but the
entire assignment will be treated as a single gradeable unit.

## Write your spec files

When you write your specs, give each example a point value.  There
are two ways to do this: in the docstring or in the metadata.

```ruby
it "works [3 points]" do ; expect(true).to eq(true) ; end
it "works", points: 3 do ; expect(true).to eq(true) ; end
```

If you specify both for the same example, you'll get a warning if the
points match and an unrecoverable exception if they don't.

The spec files should not explicitly try to `require` student code or
anything like that; the packaging (below) will do that.  

If your assignment has sequential parts in
different specfiles, name the files so that the names collate in the
order in which you want students to see results (e.g.,
`p1_foo_spec.rb` and `p2_bar_spec.rb` will sort in that order, whereas
`foo_spec.rb` and `bar_spec.rb` will sort in the opposite order).

## Package your spec files

0. Use this repo as a template.  (Don't clone or fork it; make a new
one based on these contents.)


2. In the directory `spec`, place _all_ specfiles for the
assignment.  

2. Note that this same `spec` directory contains a copy of the file
`rspec_gradescope_formatter.rb` from this repo.  Don't delete it.

2. If `/path/to/solution.rb` is a reference solution, you should be
able to run `rspec` from the toplevel directory of the cloned repo
like this:
`rspec 
