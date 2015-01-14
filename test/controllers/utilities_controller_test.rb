require 'test_helper'

class UtilitiesControllerTest < ActionController::TestCase
  setup do
    @utility = utilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:utilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create utility" do
    assert_difference('Utility.count') do
      post :create, utility: { base_rate: @utility.base_rate, demand: @utility.demand, display: @utility.display, tier1_rate: @utility.tier1_rate, tier2_rate: @utility.tier2_rate, tier3_rate: @utility.tier3_rate, utility_type: @utility.utility_type }
    end

    assert_redirected_to utility_path(assigns(:utility))
  end

  test "should show utility" do
    get :show, id: @utility
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @utility
    assert_response :success
  end

  test "should update utility" do
    patch :update, id: @utility, utility: { base_rate: @utility.base_rate, demand: @utility.demand, display: @utility.display, tier1_rate: @utility.tier1_rate, tier2_rate: @utility.tier2_rate, tier3_rate: @utility.tier3_rate, utility_type: @utility.utility_type }
    assert_redirected_to utility_path(assigns(:utility))
  end

  test "should destroy utility" do
    assert_difference('Utility.count', -1) do
      delete :destroy, id: @utility
    end

    assert_redirected_to utilities_path
  end
end
