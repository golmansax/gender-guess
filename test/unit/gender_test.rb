require 'test_helper'

class GenderTest < ActionController::TestCase
  include Gender

  test 'flip' do
    assert_equal Gender.flip('M'), 'F'
    assert_equal Gender.flip('F'), 'M'
  end
end
