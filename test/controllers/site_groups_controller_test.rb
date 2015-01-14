require 'test_helper'

class SiteGroupsControllerTest < ActionController::TestCase
  setup do
    @site_group = site_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_group" do
    assert_difference('SiteGroup.count') do
      post :create, site_group: { display: @site_group.display }
    end

    assert_redirected_to site_group_path(assigns(:site_group))
  end

  test "should show site_group" do
    get :show, id: @site_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_group
    assert_response :success
  end

  test "should update site_group" do
    patch :update, id: @site_group, site_group: { display: @site_group.display }
    assert_redirected_to site_group_path(assigns(:site_group))
  end

  test "should destroy site_group" do
    assert_difference('SiteGroup.count', -1) do
      delete :destroy, id: @site_group
    end

    assert_redirected_to site_groups_path
  end
end
