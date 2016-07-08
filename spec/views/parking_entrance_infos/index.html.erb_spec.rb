require 'rails_helper'

RSpec.describe "parking_entrance_infos/index", type: :view do
  before(:each) do
    assign(:parking_entrance_infos, [
      ParkingEntranceInfo.create!(
        :parking_entrance_id => 2,
        :multi_entrance => "Multi Entrance",
        :private_lot => "Private Lot",
        :lot => 3,
        :zone_name => "Zone Name",
        :area_name => "Area Name",
        :fpd_uid => "Fpd Uid",
        :point_type => "Point Type",
        :parking_entrance_addr => "Parking Entrance Addr",
        :trailaccess => "Trailaccess",
        :nameid => 4,
        :parking_info_id => 5,
        :entrance_closed => "Entrance Closed"
      ),
      ParkingEntranceInfo.create!(
        :parking_entrance_id => 2,
        :multi_entrance => "Multi Entrance",
        :private_lot => "Private Lot",
        :lot => 3,
        :zone_name => "Zone Name",
        :area_name => "Area Name",
        :fpd_uid => "Fpd Uid",
        :point_type => "Point Type",
        :parking_entrance_addr => "Parking Entrance Addr",
        :trailaccess => "Trailaccess",
        :nameid => 4,
        :parking_info_id => 5,
        :entrance_closed => "Entrance Closed"
      )
    ])
  end

  it "renders a list of parking_entrance_infos" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Multi Entrance".to_s, :count => 2
    assert_select "tr>td", :text => "Private Lot".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Zone Name".to_s, :count => 2
    assert_select "tr>td", :text => "Area Name".to_s, :count => 2
    assert_select "tr>td", :text => "Fpd Uid".to_s, :count => 2
    assert_select "tr>td", :text => "Point Type".to_s, :count => 2
    assert_select "tr>td", :text => "Parking Entrance Addr".to_s, :count => 2
    assert_select "tr>td", :text => "Trailaccess".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Entrance Closed".to_s, :count => 2
  end
end
