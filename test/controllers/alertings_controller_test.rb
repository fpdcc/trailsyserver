require 'test_helper'

class AlertingsControllerTest < ActionController::TestCase
  setup do
    @alerting = alertings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alertings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alerting" do
    assert_difference('Alerting.count') do
      post :create, alerting: { alert_id: @alerting.alert_id, alertable_id: @alerting.alertable_id, alertable_type: @alerting.alertable_type, created_by: @alerting.created_by, ends_at: @alerting.ends_at, starts_at: @alerting.starts_at }
    end

    assert_redirected_to alerting_path(assigns(:alerting))
  end

  test "should show alerting" do
    get :show, id: @alerting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alerting
    assert_response :success
  end

  test "should update alerting" do
    patch :update, id: @alerting, alerting: { alert_id: @alerting.alert_id, alertable_id: @alerting.alertable_id, alertable_type: @alerting.alertable_type, created_by: @alerting.created_by, ends_at: @alerting.ends_at, starts_at: @alerting.starts_at }
    assert_redirected_to alerting_path(assigns(:alerting))
  end

  test "should destroy alerting" do
    assert_difference('Alerting.count', -1) do
      delete :destroy, id: @alerting
    end

    assert_redirected_to alertings_path
  end
end
