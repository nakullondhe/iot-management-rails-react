require "test_helper"

class AlarmsControllerTest < ActionDispatch::IntegrationTest
  test "should get Api::Alarms" do
    get alarms_Api::Alarms_url
    assert_response :success
  end
end
