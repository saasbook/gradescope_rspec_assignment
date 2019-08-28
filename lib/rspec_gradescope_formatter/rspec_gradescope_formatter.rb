require 'byebug'

require 'rspec/core/formatters/base_text_formatter'
require 'json'

# @see https://gradescope-autograders.readthedocs.io/en/latest/specs/

class RSspecGradescopeFormatter < RSpec::Core::Formatters::BaseTextFormatter

  RSpec::Core::Formatters.register(self,
    :example_started,           # collect points from example name
    :example_passed, :example_failed, :example_pending, # each example
    :close)                     # run is over
  # other hooks: example_group_started, example_group_finished, example_section_finished

  def initialize(output)
    @output = output
    @total_points = 0
    @passed_points = 0
    @current_test_case = nil
    @results = {
      # "score" => 0.0, # total; required if not on each test case below. Overrides total if specified.
      # "execution_time" => 0, # optional, seconds
      # "output" => "Text relevant to the entire submission", # optional
      # "visibility" => "after_due_date", # Optional visibility setting
      # "stdout_visibility" => "visible", # Optional stdout visibility setting
      # "extra_data" => {},     # Optional extra data to be stored
      "tests" => [ ]    # Optional, but required if no top-level score
    }
  end

  # @see https://www.rubydoc.info/gems/rspec-core/RSpec/Core/Notifications
  # @see https://www.rubydoc.info/gems/rspec-core/RSpec/Core/Example
  def example_started(notification)
    example = notification.example # an instance of RSpec::Core::Example
    points = extract_points(example)
    if points > 0
      # BUG: check for example.pending - true means this example is not expected to pass
      @current_test_case = {
        'max_score' => points,
        'name' => example.full_description,
        # "number" =>  "1.1", # optional (will just be numbered in order of array if no number given)
        # "output" =>  "Giant multiline string that will be placed in a <pre> tag and collapsed by default", # optional
        # "tags" =>  ["tag1", "tag2", "tag3"], # optional
        # "visibility" =>  "visible", # Optional visibility setting
        # "extra_data" =>  {} # Optional extra data to be stored
        'output' => ''
      }
    else
      @current_test_case = nil # this prevents other methods from trying to fill in
    end
  end

  def example_passed(notification)
    @current_test_case['score'] = @current_test_case['max_score'] if @current_test_case
  end

  def example_failed(notification)
    @current_test_case['score'] = 0 if @current_test_case
    @current_test_case['output'] = 
  end

  def close(notification)
    # write all output to results.json
    
  end

  private
  def extract_points(example)
    # if an example's metadata has :points => N, extract that.
    # elsif its description includes "[N points]", extract that.
    # if it has both and they match, issue a warning
    # if it has both and they don't match, issue an error
    points_from_metadata = example.metadata.has_key?(:points) ? example.metadata[:points].to_i : nil
    points_from_description = example.description =~ /\[\s*(\d+)\s*points\s*\]\s*$/ ? $1.to_i : nil
    if points_from_metadata && points_from_description
      # if they are equal, warning for example.metadata[:location] (file path + line num)
      if points_from_metadata == points_from_description
        puts "WARNING!"
      else
        raise "ERROR!"
      end
    else
      points_from_metadata || points_from_description || 0
    end
  end

  def add_test_case(example)
    points = extract_points(example)
    return if points.zero?
    @test_cases << {
      'score' => points
    end
  end

end
