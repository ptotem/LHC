require 'test_helper'

class IcebreakerAnswersControllerTest < ActionController::TestCase
  setup do
    @icebreaker_answer = icebreaker_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:icebreaker_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create icebreaker_answer" do
    assert_difference('IcebreakerAnswer.count') do
      post :create, icebreaker_answer: { answer_id: @icebreaker_answer.answer_id, ice_breaker_id: @icebreaker_answer.ice_breaker_id, question_id: @icebreaker_answer.question_id, user_id: @icebreaker_answer.user_id }
    end

    assert_redirected_to icebreaker_answer_path(assigns(:icebreaker_answer))
  end

  test "should show icebreaker_answer" do
    get :show, id: @icebreaker_answer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @icebreaker_answer
    assert_response :success
  end

  test "should update icebreaker_answer" do
    patch :update, id: @icebreaker_answer, icebreaker_answer: { answer_id: @icebreaker_answer.answer_id, ice_breaker_id: @icebreaker_answer.ice_breaker_id, question_id: @icebreaker_answer.question_id, user_id: @icebreaker_answer.user_id }
    assert_redirected_to icebreaker_answer_path(assigns(:icebreaker_answer))
  end

  test "should destroy icebreaker_answer" do
    assert_difference('IcebreakerAnswer.count', -1) do
      delete :destroy, id: @icebreaker_answer
    end

    assert_redirected_to icebreaker_answers_path
  end
end
