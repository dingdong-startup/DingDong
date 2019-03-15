require 'test_helper'

class AdminChargesControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should get index" do
    get admin_charges_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_charges_create_url
    assert_response :success
  end

>>>>>>> dev
end
