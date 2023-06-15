require "test_helper"

class SandboxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sandbox_index_url
    assert_response :success
  end
end
