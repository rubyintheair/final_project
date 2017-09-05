require 'test_helper'

class BanksControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get banks_display_url
    assert_response :success
  end

end
