require 'rails_helper'

RSpec.describe "poi_infos/show", type: :view do
  before(:each) do
    @poi_info = assign(:poi_info, PoiInfo.create!(
      :poi_info_id => 2,
      :point_type => "Point Type",
      :addr => "Addr",
      :zip => "Zip",
      :zipmuni => "Zipmuni",
      :municipality => "Municipality",
      :public_access => "Public Access",
      :latitude => "9.99",
      :longitude => "9.99",
      :commdist => 3,
      :zone_name => "Zone Name",
      :zonemapno => 4,
      :dwmapno => 5,
      :nameid => 6,
      :pointsofinterest_id => 7,
      :fpd_uid => 8,
      :web_poi => "Web Poi",
      :web_street_addr => "Web Street Addr",
      :web_muni_addr => "Web Muni Addr",
      :parking_connection_id => 9,
      :parking_info_id => 10,
      :alt_nameid => 11,
      :alt2_nameid => 12
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Point Type/)
    expect(rendered).to match(/Addr/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/Zipmuni/)
    expect(rendered).to match(/Municipality/)
    expect(rendered).to match(/Public Access/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Zone Name/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/Web Poi/)
    expect(rendered).to match(/Web Street Addr/)
    expect(rendered).to match(/Web Muni Addr/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
    expect(rendered).to match(/12/)
  end
end
