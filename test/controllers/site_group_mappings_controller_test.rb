require 'test_helper'

class SiteGroupMappingsControllerTest < ActionController::TestCase
  setup do
    @site_group_mapping = site_group_mappings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_group_mappings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_group_mapping" do
    assert_difference('SiteGroupMapping.count') do
      post :create, site_group_mapping: { site_group_id: @site_group_mapping.site_group_id, site_id: @site_group_mapping.site_id }
    end

    assert_redirected_to site_group_mapping_path(assigns(:site_group_mapping))
  end

  test "should show site_group_mapping" do
    get :show, id: @site_group_mapping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_group_mapping
    assert_response :success
  end

  test "should update site_group_mapping" do
    patch :update, id: @site_group_mapping, site_group_mapping: { site_group_id: @site_group_mapping.site_group_id, site_id: @site_group_mapping.site_id }
    assert_redirected_to site_group_mapping_path(assigns(:site_group_mapping))
  end

  test "should destroy site_group_mapping" do
    assert_difference('SiteGroupMapping.count', -1) do
      delete :destroy, id: @site_group_mapping
    end

    assert_redirected_to site_group_mappings_path
  end
end
