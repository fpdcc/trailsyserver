require 'rails_helper'

RSpec.describe "trail_systems/index", type: :view do
  before(:each) do
    assign(:trail_systems, [
      TrailSystem.create!(
        :trail_subsystem => "Trail Subsystem"
      ),
      TrailSystem.create!(
        :trail_subsystem => "Trail Subsystem"
      )
    ])
  end

  it "renders a list of trail_systems" do
    render
    assert_select "tr>td", :text => "Trail Subsystem".to_s, :count => 2
  end
end
