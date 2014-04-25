require 'test_helper'

class QuizCategoriesControllerTest < ActionController::TestCase
  setup do
    @quiz_category = quiz_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiz_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz_category" do
    assert_difference('QuizCategory.count') do
      post :create, quiz_category: { intro: @quiz_category.intro, name: @quiz_category.name, status: @quiz_category.status }
    end

    assert_redirected_to quiz_category_path(assigns(:quiz_category))
  end

  test "should show quiz_category" do
    get :show, id: @quiz_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiz_category
    assert_response :success
  end

  test "should update quiz_category" do
    patch :update, id: @quiz_category, quiz_category: { intro: @quiz_category.intro, name: @quiz_category.name, status: @quiz_category.status }
    assert_redirected_to quiz_category_path(assigns(:quiz_category))
  end

  test "should destroy quiz_category" do
    assert_difference('QuizCategory.count', -1) do
      delete :destroy, id: @quiz_category
    end

    assert_redirected_to quiz_categories_path
  end
end
