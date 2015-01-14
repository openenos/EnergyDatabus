require 'test_helper'

class ElecLoadTypesControllerTest < ActionController::TestCase
  setup do
    @elec_load_type = elec_load_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:elec_load_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create elec_load_type" do
    assert_difference('ElecLoadType.count') do
      post :create, elec_load_type: { dispaly: @elec_load_type.dispaly, load_type: @elec_load_type.load_type }
    end

    assert_redirected_to elec_load_type_path(assigns(:elec_load_type))
  end

  test "should show elec_load_type" do
    get :show, id: @elec_load_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @elec_load_type
    assert_response :success
  end

  test "should update elec_load_type" do
    patch :update, id: @elec_load_type, elec_load_type: { dispaly: @elec_load_type.dispaly, load_type: @elec_load_type.load_type }
    assert_redirected_to elec_load_type_path(assigns(:elec_load_type))
  end

  test "should destroy elec_load_type" do
    assert_difference('ElecLoadType.count', -1) do
      delete :destroy, id: @elec_load_type
    end

    assert_redirected_to elec_load_types_path
  end
end
