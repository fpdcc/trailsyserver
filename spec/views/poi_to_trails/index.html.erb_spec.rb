require 'rails_helper'

RSpec.describe "poi_to_trails/index", type: :view do
  before(:each) do
    assign(:poi_to_trails, [
      PoiToTrail.create!(
        :trail_info_id => 2,
        :poi_info_id => 3,
        :distance => "9.99"
      ),
      PoiToTrail.create!(
        :trail_info_id => 2,
        :poi_info_id => 3,
        :distance => "9.99"
      )
    ])
  end

  it "renders a list of poi_to_trails" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
