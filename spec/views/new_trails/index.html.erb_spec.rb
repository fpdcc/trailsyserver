require 'rails_helper'

RSpec.describe "new_trails/index", type: :view do
  before(:each) do
    assign(:new_trails, [
      NewTrail.create!(
        :trails_id => 2,
        :geom => ""
      ),
      NewTrail.create!(
        :trails_id => 2,
        :geom => ""
      )
    ])
  end

  it "renders a list of new_trails" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
