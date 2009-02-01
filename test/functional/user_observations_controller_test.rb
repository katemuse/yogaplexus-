require 'test_helper'

class UserObservationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:user_observations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_user_observation
    assert_difference('UserObservation.count') do
      post :create, :user_observation => { }
    end

    assert_redirected_to user_observation_path(assigns(:user_observation))
  end

  def test_should_show_user_observation
    get :show, :id => user_observations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => user_observations(:one).id
    assert_response :success
  end

  def test_should_update_user_observation
    put :update, :id => user_observations(:one).id, :user_observation => { }
    assert_redirected_to user_observation_path(assigns(:user_observation))
  end

  def test_should_destroy_user_observation
    assert_difference('UserObservation.count', -1) do
      delete :destroy, :id => user_observations(:one).id
    end

    assert_redirected_to user_observations_path
  end
end
