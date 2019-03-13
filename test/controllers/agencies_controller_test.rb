require 'test_helper'

class AgenciesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get agencies_index_url
    assert_response :success
  end

  test "should get show" do
    get agencies_show_url
    assert_response :success
  end

end
