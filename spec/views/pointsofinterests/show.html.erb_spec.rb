require 'rails_helper'

RSpec.describe "pointsofinterests/show", type: :view do
  before(:each) do
    @pointsofinterest = assign(:pointsofinterest, Pointsofinterest.create!(
      :pointsofinterest_id => 2,
      :geom => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
