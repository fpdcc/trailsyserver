require 'rails_helper'

RSpec.describe "parking_entrance_infos/show", type: :view do
  before(:each) do
    @parking_entrance_info = assign(:parking_entrance_info, ParkingEntranceInfo.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Multi Entrance/)
    expect(rendered).to match(/Private Lot/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Zone Name/)
    expect(rendered).to match(/Area Name/)
    expect(rendered).to match(/Fpd Uid/)
    expect(rendered).to match(/Point Type/)
    expect(rendered).to match(/Parking Entrance Addr/)
    expect(rendered).to match(/Trailaccess/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Entrance Closed/)
  end
end
