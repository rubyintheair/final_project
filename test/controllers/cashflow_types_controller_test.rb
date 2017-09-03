require 'test_helper'

class CashflowTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cashflow_types_new_url
    assert_response :success
  end

end
