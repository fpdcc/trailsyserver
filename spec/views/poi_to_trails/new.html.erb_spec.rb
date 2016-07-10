require 'rails_helper'

RSpec.describe "poi_to_trails/new", type: :view do
  before(:each) do
    assign(:poi_to_trail, PoiToTrail.new(
      :trail_info_id => 1,
      :poi_info_id => 1,
      :distance => "9.99"
    ))
  end

  it "renders new poi_to_trail form" do
    render

    assert_select "form[action=?][method=?]", poi_to_trails_path, "post" do

      assert_select "input#poi_to_trail_trail_info_id[name=?]", "poi_to_trail[trail_info_id]"

      assert_select "input#poi_to_trail_poi_info_id[name=?]", "poi_to_trail[poi_info_id]"

      assert_select "input#poi_to_trail_distance[name=?]", "poi_to_trail[distance]"
    end
  end
end
