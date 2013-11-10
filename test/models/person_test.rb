require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "valid people" do
    person = people(:holman)
    assert person.save

    person = people(:scarlett)
    assert person.save
  end

  test "bogus gender" do
    person = people(:bogus_gender)
    assert !person.save
  end

  test "negative height" do
    person = people(:negative_height)
    assert !person.save
  end

  test "negative weight" do
    person = people(:negative_weight)
    assert !person.save
  end
end
