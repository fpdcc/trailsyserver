require 'rails_helper'

RSpec.describe "pointsofinterests/index", type: :view do
  before(:each) do
    assign(:pointsofinterests, [
      Pointsofinterest.create!(
        :pointsofinterest_id => 2,
        :geom => ""
      ),
      Pointsofinterest.create!(
        :pointsofinterest_id => 2,
        :geom => ""
      )
    ])
  end

  it "renders a list of pointsofinterests" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
