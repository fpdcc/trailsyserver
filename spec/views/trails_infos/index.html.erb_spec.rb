require 'rails_helper'

RSpec.describe "trails_infos/index", type: :view do
  before(:each) do
    assign(:trails_infos, [
      TrailsInfo.create!(
        :trail_system => "Trail System",
        :trail_subsystem => "Trail Subsystem",
        :trail_color => "Trail Color",
        :trail_surface => "Trail Surface",
        :trail_type => "Trail Type",
        :trail_difficulty => "Trail Difficulty",
        :regional_trail_name => "Regional Trail Name",
        :trail_desc => "Trail Desc",
        :gps => "Gps",
        :comment => "Comment",
        :alt_name => "Alt Name",
        :cambr_name => "Cambr Name",
        :on_street => "On Street",
        :crossing_type => "Crossing Type",
        :unrecognized => "Unrecognized",
        :length_mi => "9.99",
        :trails_id => 2,
        :off_fpdcc => "Off Fpdcc",
        :web_trail => "Web Trail",
        :maintenance => "Maintenance",
        :length_ft => "9.99",
        :trail_info_id => 3
      ),
      TrailsInfo.create!(
        :trail_system => "Trail System",
        :trail_subsystem => "Trail Subsystem",
        :trail_color => "Trail Color",
        :trail_surface => "Trail Surface",
        :trail_type => "Trail Type",
        :trail_difficulty => "Trail Difficulty",
        :regional_trail_name => "Regional Trail Name",
        :trail_desc => "Trail Desc",
        :gps => "Gps",
        :comment => "Comment",
        :alt_name => "Alt Name",
        :cambr_name => "Cambr Name",
        :on_street => "On Street",
        :crossing_type => "Crossing Type",
        :unrecognized => "Unrecognized",
        :length_mi => "9.99",
        :trails_id => 2,
        :off_fpdcc => "Off Fpdcc",
        :web_trail => "Web Trail",
        :maintenance => "Maintenance",
        :length_ft => "9.99",
        :trail_info_id => 3
      )
    ])
  end

  it "renders a list of trails_infos" do
    render
    assert_select "tr>td", :text => "Trail System".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Subsystem".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Color".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Surface".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Type".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Difficulty".to_s, :count => 2
    assert_select "tr>td", :text => "Regional Trail Name".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Desc".to_s, :count => 2
    assert_select "tr>td", :text => "Gps".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "Alt Name".to_s, :count => 2
    assert_select "tr>td", :text => "Cambr Name".to_s, :count => 2
    assert_select "tr>td", :text => "On Street".to_s, :count => 2
    assert_select "tr>td", :text => "Crossing Type".to_s, :count => 2
    assert_select "tr>td", :text => "Unrecognized".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Off Fpdcc".to_s, :count => 2
    assert_select "tr>td", :text => "Web Trail".to_s, :count => 2
    assert_select "tr>td", :text => "Maintenance".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
