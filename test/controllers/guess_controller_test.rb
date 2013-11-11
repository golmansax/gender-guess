require 'test_helper'

class GuessControllerTest < ActionController::TestCase
  test "make guess" do
    person = people(:holman)
    person_params = get_person_params(person)

    get :guess_parse, { person: person_params }
    assert_redirected_to guess_path(person.height, person.weight)
  end

  test "negative height" do
    person = people(:negative_height)
    person_params = get_person_params(person)

    get :guess_parse, { person: person_params }

    # Form path only takes height and weight
    person_params.delete(:gender)
    assert_redirected_to form_path(person_params)
  end

  private
    def get_person_params(person)
      return {
        height: person.height, weight: person.weight, gender: person.gender
      }
    end
end
