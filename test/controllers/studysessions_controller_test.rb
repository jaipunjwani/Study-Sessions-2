require 'test_helper'

class StudysessionsControllerTest < ActionController::TestCase
  setup do
    @studysession = studysessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:studysessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create studysession" do
    assert_difference('Studysession.count') do
      post :create, studysession: { description: @studysession.description, location: @studysession.location, subject: @studysession.subject }
    end

    assert_redirected_to studysession_path(assigns(:studysession))
  end

  test "should show studysession" do
    get :show, id: @studysession
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @studysession
    assert_response :success
  end

  test "should update studysession" do
    patch :update, id: @studysession, studysession: { description: @studysession.description, location: @studysession.location, subject: @studysession.subject }
    assert_redirected_to studysession_path(assigns(:studysession))
  end

  test "should destroy studysession" do
    assert_difference('Studysession.count', -1) do
      delete :destroy, id: @studysession
    end

    assert_redirected_to studysessions_path
  end
end
