require 'rails_helper'

RSpec.describe "parking_entrance_infos/edit", type: :view do
  before(:each) do
    @parking_entrance_info = assign(:parking_entrance_info, ParkingEntranceInfo.create!(
      :parking_entrance_id => 1,
      :multi_entrance => "MyString",
      :private_lot => "MyString",
      :lot => 1,
      :zone_name => "MyString",
      :area_name => "MyString",
      :fpd_uid => "MyString",
      :point_type => "MyString",
      :parking_entrance_addr => "MyString",
      :trailaccess => "MyString",
      :nameid => 1,
      :parking_info_id => 1,
      :entrance_closed => "MyString"
    ))
  end

  it "renders the edit parking_entrance_info form" do
    render

    assert_select "form[action=?][method=?]", parking_entrance_info_path(@parking_entrance_info), "post" do

      assert_select "input#parking_entrance_info_parking_entrance_id[name=?]", "parking_entrance_info[parking_entrance_id]"

      assert_select "input#parking_entrance_info_multi_entrance[name=?]", "parking_entrance_info[multi_entrance]"

      assert_select "input#parking_entrance_info_private_lot[name=?]", "parking_entrance_info[private_lot]"

      assert_select "input#parking_entrance_info_lot[name=?]", "parking_entrance_info[lot]"

      assert_select "input#parking_entrance_info_zone_name[name=?]", "parking_entrance_info[zone_name]"

      assert_select "input#parking_entrance_info_area_name[name=?]", "parking_entrance_info[area_name]"

      assert_select "input#parking_entrance_info_fpd_uid[name=?]", "parking_entrance_info[fpd_uid]"

      assert_select "input#parking_entrance_info_point_type[name=?]", "parking_entrance_info[point_type]"

      assert_select "input#parking_entrance_info_parking_entrance_addr[name=?]", "parking_entrance_info[parking_entrance_addr]"

      assert_select "input#parking_entrance_info_trailaccess[name=?]", "parking_entrance_info[trailaccess]"

      assert_select "input#parking_entrance_info_nameid[name=?]", "parking_entrance_info[nameid]"

      assert_select "input#parking_entrance_info_parking_info_id[name=?]", "parking_entrance_info[parking_info_id]"

      assert_select "input#parking_entrance_info_entrance_closed[name=?]", "parking_entrance_info[entrance_closed]"
    end
  end
end
