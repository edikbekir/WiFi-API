require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visitor = users(:one)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create visitor" do
    assert_difference('Visitor.count') do
      post users_url, params: { visitor: { email: @visitor.email, password_digest: @visitor.password_digest } }, as: :json
    end

    assert_response 201
  end

  test "should show visitor" do
    get user_url(@visitor), as: :json
    assert_response :success
  end

  test "should update visitor" do
    patch user_url(@visitor), params: { visitor: { email: @visitor.email, password_digest: @visitor.password_digest } }, as: :json
    assert_response 200
  end

  test "should destroy visitor" do
    assert_difference('Visitor.count', -1) do
      delete user_url(@visitor), as: :json
    end

    assert_response 204
  end
end
