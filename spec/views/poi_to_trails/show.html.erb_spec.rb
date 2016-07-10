require 'rails_helper'

RSpec.describe "poi_to_trails/show", type: :view do
  before(:each) do
    @poi_to_trail = assign(:poi_to_trail, PoiToTrail.create!(
      :trail_info_id => 2,
      :poi_info_id => 3,
      :distance => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/9.99/)
  end
end
