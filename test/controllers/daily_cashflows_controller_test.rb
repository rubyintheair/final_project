require 'test_helper'

class DailyCashflowsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get daily_cashflows_new_url
    assert_response :success
  end

  test "should get index" do
    get daily_cashflows_index_url
    assert_response :success
  end

end
