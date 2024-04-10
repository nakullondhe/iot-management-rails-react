require "test_helper"

class Api::PotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_pot = api_pots(:one)
  end

  test "should get index" do
    get api_pots_url, as: :json
    assert_response :success
  end

  test "should create api_pot" do
    assert_difference("Api::Pot.count") do
      post api_pots_url, params: { api_pot: { context: @api_pot.context, title: @api_pot.title } }, as: :json
    end

    assert_response :created
  end

  test "should show api_pot" do
    get api_pot_url(@api_pot), as: :json
    assert_response :success
  end

  test "should update api_pot" do
    patch api_pot_url(@api_pot), params: { api_pot: { context: @api_pot.context, title: @api_pot.title } }, as: :json
    assert_response :success
  end

  test "should destroy api_pot" do
    assert_difference("Api::Pot.count", -1) do
      delete api_pot_url(@api_pot), as: :json
    end

    assert_response :no_content
  end
end
