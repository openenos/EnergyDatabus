require 'test_helper'

class CircuitsControllerTest < ActionController::TestCase
  setup do
    @circuit = circuits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:circuits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create circuit" do
    assert_difference('Circuit.count') do
      post :create, circuit: { active: @circuit.active, breaker_number: @circuit.breaker_number, breaker_size: @circuit.breaker_size, channel_no: @circuit.channel_no, ct_sensor_type: @circuit.ct_sensor_type, display: @circuit.display, double_breaker: @circuit.double_breaker, double_ct: @circuit.double_ct, elec_load_type_id: @circuit.elec_load_type_id, input: @circuit.input, panel_id: @circuit.panel_id }
    end

    assert_redirected_to circuit_path(assigns(:circuit))
  end

  test "should show circuit" do
    get :show, id: @circuit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @circuit
    assert_response :success
  end

  test "should update circuit" do
    patch :update, id: @circuit, circuit: { active: @circuit.active, breaker_number: @circuit.breaker_number, breaker_size: @circuit.breaker_size, channel_no: @circuit.channel_no, ct_sensor_type: @circuit.ct_sensor_type, display: @circuit.display, double_breaker: @circuit.double_breaker, double_ct: @circuit.double_ct, elec_load_type_id: @circuit.elec_load_type_id, input: @circuit.input, panel_id: @circuit.panel_id }
    assert_redirected_to circuit_path(assigns(:circuit))
  end

  test "should destroy circuit" do
    assert_difference('Circuit.count', -1) do
      delete :destroy, id: @circuit
    end

    assert_redirected_to circuits_path
  end
end
