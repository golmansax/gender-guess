require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :people

  test "correct guess" do
    get form_path

    # Mimic entering in height and weight
    person = people(:scarlett)
    person_params = {
      height: person.height, weight: person.weight, gender: person.gender
    }
    post_via_redirect guess_parse_path, { person: person_params }
    assert_equal path, "/gender-guess/guess/#{person.height}/#{person.weight}"

    # Mimic guess and user saying that response was correct
    guess_params = person_params
    guess_params[:guessed_gender] = person.gender
    post_via_redirect correct_path, guess_params
    assert_equal path, '/gender-guess/results'
  end
end
