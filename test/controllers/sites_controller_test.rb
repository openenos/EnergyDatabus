require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  setup do
    @site = sites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post :create, site: { area_cond_square_foot: @site.area_cond_square_foot, area_gross_square_foot: @site.area_gross_square_foot, display: @site.display, location_id: @site.location_id, operating_hours: @site.operating_hours, site_ref: @site.site_ref, year_built: @site.year_built }
    end

    assert_redirected_to site_path(assigns(:site))
  end

  test "should show site" do
    get :show, id: @site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site
    assert_response :success
  end

  test "should update site" do
    patch :update, id: @site, site: { area_cond_square_foot: @site.area_cond_square_foot, area_gross_square_foot: @site.area_gross_square_foot, display: @site.display, location_id: @site.location_id, operating_hours: @site.operating_hours, site_ref: @site.site_ref, year_built: @site.year_built }
    assert_redirected_to site_path(assigns(:site))
  end

  test "should destroy site" do
    assert_difference('Site.count', -1) do
      delete :destroy, id: @site
    end

    assert_redirected_to sites_path
  end
end
