require 'rails_helper'

RSpec.describe "trail_subtrails/index", type: :view do
  before(:each) do
    assign(:trail_subtrails, [
      TrailSubtrail.create!(),
      TrailSubtrail.create!()
    ])
  end

  it "renders a list of trail_subtrails" do
    render
  end
end
