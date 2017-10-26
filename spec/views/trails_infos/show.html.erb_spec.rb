require 'rails_helper'

RSpec.describe "trails_infos/show", type: :view do
  before(:each) do
    @trails_info = assign(:trails_info, TrailsInfo.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Trail System/)
    expect(rendered).to match(/Trail Subsystem/)
    expect(rendered).to match(/Trail Color/)
    expect(rendered).to match(/Trail Surface/)
    expect(rendered).to match(/Trail Type/)
    expect(rendered).to match(/Trail Difficulty/)
    expect(rendered).to match(/Regional Trail Name/)
    expect(rendered).to match(/Trail Desc/)
    expect(rendered).to match(/Gps/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/Alt Name/)
    expect(rendered).to match(/Cambr Name/)
    expect(rendered).to match(/On Street/)
    expect(rendered).to match(/Crossing Type/)
    expect(rendered).to match(/Unrecognized/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Off Fpdcc/)
    expect(rendered).to match(/Web Trail/)
    expect(rendered).to match(/Maintenance/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/3/)
  end
end
