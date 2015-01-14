require 'test_helper'

class PanelsControllerTest < ActionController::TestCase
  setup do
    @panel = panels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:panels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create panel" do
    assert_difference('Panel.count') do
      post :create, panel: { amp: @panel.amp, emon_url: @panel.emon_url, equip_ref: @panel.equip_ref, no_of_circuits: @panel.no_of_circuits, panel_type: @panel.panel_type, parent_panel_id: @panel.parent_panel_id, site_id: @panel.site_id }
    end

    assert_redirected_to panel_path(assigns(:panel))
  end

  test "should show panel" do
    get :show, id: @panel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @panel
    assert_response :success
  end

  test "should update panel" do
    patch :update, id: @panel, panel: { amp: @panel.amp, emon_url: @panel.emon_url, equip_ref: @panel.equip_ref, no_of_circuits: @panel.no_of_circuits, panel_type: @panel.panel_type, parent_panel_id: @panel.parent_panel_id, site_id: @panel.site_id }
    assert_redirected_to panel_path(assigns(:panel))
  end

  test "should destroy panel" do
    assert_difference('Panel.count', -1) do
      delete :destroy, id: @panel
    end

    assert_redirected_to panels_path
  end
end
