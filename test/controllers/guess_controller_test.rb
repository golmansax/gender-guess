require 'test_helper'

class GuessControllerTest < ActionController::TestCase
  test "make guess" do
    person = people(:holman)

    get :guess_parse, { person: person }
    assert_redirected_to guess_path
  end
end
