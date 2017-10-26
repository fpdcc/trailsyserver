require 'rails_helper'

RSpec.describe "parking_entrances/new", type: :view do
  before(:each) do
    assign(:parking_entrance, ParkingEntrance.new(
      :parking_entrance_id => 1,
      :geom => ""
    ))
  end

  it "renders new parking_entrance form" do
    render

    assert_select "form[action=?][method=?]", parking_entrances_path, "post" do

      assert_select "input#parking_entrance_parking_entrance_id[name=?]", "parking_entrance[parking_entrance_id]"

      assert_select "input#parking_entrance_geom[name=?]", "parking_entrance[geom]"
    end
  end
end
