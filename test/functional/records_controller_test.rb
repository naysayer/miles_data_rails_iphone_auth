require 'test_helper'

class RecordsControllerTest < ActionController::TestCase
  setup do
    @record = records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create record" do
    assert_difference('Record.count') do
      post :create, record: { car: @record.car, reason: @record.reason, start_lat: @record.start_lat, start_location: @record.start_location, start_long: @record.start_long, start_odometer: @record.start_odometer, start_use_coords: @record.start_use_coords, stop_lat: @record.stop_lat, stop_location: @record.stop_location, stop_long: @record.stop_long, stop_odometer: @record.stop_odometer, stop_use_coords: @record.stop_use_coords }
    end

    assert_redirected_to record_path(assigns(:record))
  end

  test "should show record" do
    get :show, id: @record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @record
    assert_response :success
  end

  test "should update record" do
    put :update, id: @record, record: { car: @record.car, reason: @record.reason, start_lat: @record.start_lat, start_location: @record.start_location, start_long: @record.start_long, start_odometer: @record.start_odometer, start_use_coords: @record.start_use_coords, stop_lat: @record.stop_lat, stop_location: @record.stop_location, stop_long: @record.stop_long, stop_odometer: @record.stop_odometer, stop_use_coords: @record.stop_use_coords }
    assert_redirected_to record_path(assigns(:record))
  end

  test "should destroy record" do
    assert_difference('Record.count', -1) do
      delete :destroy, id: @record
    end

    assert_redirected_to records_path
  end
end
