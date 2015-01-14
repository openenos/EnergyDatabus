require 'test_helper'

class ElecMetersControllerTest < ActionController::TestCase
  setup do
    @elec_meter = elec_meters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:elec_meters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create elec_meter" do
    assert_difference('ElecMeter.count') do
      post :create, elec_meter: { amp: @elec_meter.amp, display: @elec_meter.display, meter_loc: @elec_meter.meter_loc, meter_main: @elec_meter.meter_main, meter_type: @elec_meter.meter_type, phase: @elec_meter.phase, site_id: @elec_meter.site_id, volt: @elec_meter.volt }
    end

    assert_redirected_to elec_meter_path(assigns(:elec_meter))
  end

  test "should show elec_meter" do
    get :show, id: @elec_meter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @elec_meter
    assert_response :success
  end

  test "should update elec_meter" do
    patch :update, id: @elec_meter, elec_meter: { amp: @elec_meter.amp, display: @elec_meter.display, meter_loc: @elec_meter.meter_loc, meter_main: @elec_meter.meter_main, meter_type: @elec_meter.meter_type, phase: @elec_meter.phase, site_id: @elec_meter.site_id, volt: @elec_meter.volt }
    assert_redirected_to elec_meter_path(assigns(:elec_meter))
  end

  test "should destroy elec_meter" do
    assert_difference('ElecMeter.count', -1) do
      delete :destroy, id: @elec_meter
    end

    assert_redirected_to elec_meters_path
  end
end
