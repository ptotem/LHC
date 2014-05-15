require 'test_helper'

class IceBreakersControllerTest < ActionController::TestCase
  setup do
    @ice_breaker = ice_breakers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ice_breakers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ice_breaker" do
    assert_difference('IceBreaker.count') do
      post :create, ice_breaker: {  }
    end

    assert_redirected_to ice_breaker_path(assigns(:ice_breaker))
  end

  test "should show ice_breaker" do
    get :show, id: @ice_breaker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ice_breaker
    assert_response :success
  end

  test "should update ice_breaker" do
    patch :update, id: @ice_breaker, ice_breaker: {  }
    assert_redirected_to ice_breaker_path(assigns(:ice_breaker))
  end

  test "should destroy ice_breaker" do
    assert_difference('IceBreaker.count', -1) do
      delete :destroy, id: @ice_breaker
    end

    assert_redirected_to ice_breakers_path
  end
end
