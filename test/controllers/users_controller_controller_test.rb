require 'test_helper'

class UsersControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get users_controller_add_url
    assert_response :success
  end

end
