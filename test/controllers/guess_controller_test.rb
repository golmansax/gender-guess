require 'test_helper'

class GuessControllerTest < ActionController::TestCase
  test "make guess" do
    person = people(:holman)
    person_params = {
      height: person.height, weight: person.weight, gender: person.gender
    }

    get :guess_parse, { person: person_params }
    assert_redirected_to guess_path(person.height, person.weight)
  end
end
