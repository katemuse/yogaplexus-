require 'test_helper'

class AsanasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:asanas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_asana
    assert_difference('Asana.count') do
      post :create, :asana => { }
    end

    assert_redirected_to asana_path(assigns(:asana))
  end

  def test_should_show_asana
    get :show, :id => asanas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => asanas(:one).id
    assert_response :success
  end

  def test_should_update_asana
    put :update, :id => asanas(:one).id, :asana => { }
    assert_redirected_to asana_path(assigns(:asana))
  end

  def test_should_destroy_asana
    assert_difference('Asana.count', -1) do
      delete :destroy, :id => asanas(:one).id
    end

    assert_redirected_to asanas_path
  end
end
