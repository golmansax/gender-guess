require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "valid people" do
    person = people(:holman)
    assert person.valid?

    person = people(:scarlett)
    assert person.valid?
  end

  test "bogus gender" do
    person = people(:bogus_gender)
    assert !person.valid?
  end

  test "negative height" do
    person = people(:negative_height)
    assert !person.valid?
  end

  test "negative weight" do
    person = people(:negative_weight)
    assert !person.valid?
  end
end
