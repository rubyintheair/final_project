require 'test_helper'

class PurposesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get purposes_new_url
    assert_response :success
  end

end
