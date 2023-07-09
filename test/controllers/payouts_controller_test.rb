require "test_helper"

class PayoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get payouts_new_url
    assert_response :success
  end

  test "should get create" do
    get payouts_create_url
    assert_response :success
  end

  test "should get update" do
    get payouts_update_url
    assert_response :success
  end
end
