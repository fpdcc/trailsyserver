require 'rails_helper'

RSpec.describe "parking_entrances/edit", type: :view do
  before(:each) do
    @parking_entrance = assign(:parking_entrance, ParkingEntrance.create!(
      :parking_entrance_id => 1,
      :geom => ""
    ))
  end

  it "renders the edit parking_entrance form" do
    render

    assert_select "form[action=?][method=?]", parking_entrance_path(@parking_entrance), "post" do

      assert_select "input#parking_entrance_parking_entrance_id[name=?]", "parking_entrance[parking_entrance_id]"

      assert_select "input#parking_entrance_geom[name=?]", "parking_entrance[geom]"
    end
  end
end
