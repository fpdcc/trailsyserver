require 'rails_helper'

RSpec.describe "trail_subtrails/show", type: :view do
  before(:each) do
    @trail_subtrail = assign(:trail_subtrail, TrailSubtrail.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
