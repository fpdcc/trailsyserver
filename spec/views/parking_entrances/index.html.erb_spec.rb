require 'rails_helper'

RSpec.describe "parking_entrances/index", type: :view do
  before(:each) do
    assign(:parking_entrances, [
      ParkingEntrance.create!(
        :parking_entrance_id => 2,
        :geom => ""
      ),
      ParkingEntrance.create!(
        :parking_entrance_id => 2,
        :geom => ""
      )
    ])
  end

  it "renders a list of parking_entrances" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
