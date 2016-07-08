require 'rails_helper'

RSpec.describe "parking_entrances/show", type: :view do
  before(:each) do
    @parking_entrance = assign(:parking_entrance, ParkingEntrance.create!(
      :parking_entrance_id => 2,
      :geom => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
