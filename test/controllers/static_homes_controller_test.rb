require 'test_helper'

class StaticHomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get static_homes_index_url
    assert_response :success
  end

end
