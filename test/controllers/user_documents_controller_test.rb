require 'test_helper'

class UserDocumentsControllerTest < ActionController::TestCase
  setup do
    @user_document = user_documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_document" do
    assert_difference('UserDocument.count') do
      post :create, user_document: { verification_text: @user_document.verification_text }
    end

    assert_redirected_to user_document_path(assigns(:user_document))
  end

  test "should show user_document" do
    get :show, id: @user_document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_document
    assert_response :success
  end

  test "should update user_document" do
    patch :update, id: @user_document, user_document: { verification_text: @user_document.verification_text }
    assert_redirected_to user_document_path(assigns(:user_document))
  end

  test "should destroy user_document" do
    assert_difference('UserDocument.count', -1) do
      delete :destroy, id: @user_document
    end

    assert_redirected_to user_documents_path
  end
end
