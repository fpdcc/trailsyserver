require 'test_helper'

class TrailheadsControllerTest < ActionController::TestCase
  setup do
    @trailhead = trailheads(:one)
    #sign_in :user, @user 
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trailheads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # Create is currently disabled
  # test "should create trailhead" do
  #   assert_difference('Trailhead.count') do
  #     post :create, trailhead: { geom: @trailhead.geom, name: @trailhead.name, source: @trailhead.source, trail1: @trailhead.trail1, trail2: @trailhead.trail2, trail3: @trailhead.trail3, poi_type: @trailhead.poi_type, segment_ids: @trailhead.segment_ids, trailhead_id: @trailhead.trailhead_id, trail_ids: @trailhead.trail_ids }
  #   end

  #   assert_redirected_to trailhead_path(assigns(:trailhead))
  # end

  test "should show trailhead" do
    get :show, id: @trailhead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trailhead
    assert_response :success
  end

  test "should update trailhead" do
    patch :update, id: @trailhead, trailhead: { geom: @trailhead.geom, name: @trailhead.name, source: @trailhead.source, trail1: @trailhead.trail1, trail2: @trailhead.trail2, trail3: @trailhead.trail3, poi_type: @trailhead.poi_type, segment_ids: @trailhead.segment_ids, trailhead_id: @trailhead.trailhead_id, trail_ids: @trailhead.trail_ids }
    assert_redirected_to trailhead_path(assigns(:trailhead))
  end

  test "should destroy trailhead" do
    assert_difference('Trailhead.count', -1) do
      delete :destroy, id: @trailhead
    end

    assert_redirected_to trailheads_path
  end
end
