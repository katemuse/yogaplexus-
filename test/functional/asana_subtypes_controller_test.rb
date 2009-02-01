require 'test_helper'

class AsanaSubtypesControllerTest < ActionController::TestCase
 
    def test_should_get_index 
      get :index
      assert_response :success
      assert_not_nil assigns(:asana_subtypes)
    end

    def test_should_get_new
      get :new
      assert_response :success
    end

    def test_should_create_asana_subtype
      assert_difference('AsanaSubtype.count') do
        post :create, :asana_subtype => { }
      end
      assert_redirected_to asana_subtype_path(assigns(:asana_subtype))
    end

    def test_should_show_asana_subtype
      get :show, :id => asana_subtypes(:one).id
      assert_response :success
    end

    def test_should_get_edit
      get :edit, :id => asana_subtypes(:one).id
      assert_response :success
    end

    def test_should_update_asana_subtype
      put :update, :id => asana_subtypes(:one).id, :asana_subtype => { }
      assert_redirected_to asana_subtype_path(assigns(:asana_subtype))
    end

    def test_should_destroy_asana_subtype
      assert_difference('AsanaSubtype.count', -1) do
        delete :destroy, :id => asana_subtypes(:one).id
      end

      assert_redirected_to asana_subtypes_path
    end
  end


