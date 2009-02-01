require 'test_helper'

class AsanaTypesControllerTest < ActionController::TestCase
 
    def test_should_get_index
      get :index
      assert_response :success
      assert_not_nil assigns(:asana_types)
    end

    def test_should_get_new
      get :new
      assert_response :success
    end

    def test_should_create_asana_type
      assert_difference('Asana.count') do
        post :create, :asana_type => { }
      end

      assert_redirected_to asana_type_path(assigns(:asana_type))
    end

    def test_should_show_asana_type
      get :show, :id => asana_types(:one).id
      assert_response :success
    end

    def test_should_get_edit
      get :edit, :id => asana_types(:one).id
      assert_response :success
    end

    def test_should_update_asana_type
      put :update, :id => asana_types(:one).id, :asana_type => { }
      assert_redirected_to asana_type_path(assigns(:asana_type))
    end

    def test_should_destroy_asana_type
      assert_difference('Asana.count', -1) do
        delete :destroy, :id => asana_types(:one).id
      end

      assert_redirected_to asana_types_path
    end
  end

end
