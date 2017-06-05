require 'rails_helper'

RSpec.describe "trail_subtrails/new", type: :view do
  before(:each) do
    assign(:trail_subtrail, TrailSubtrail.new())
  end

  it "renders new trail_subtrail form" do
    render

    assert_select "form[action=?][method=?]", trail_subtrails_path, "post" do
    end
  end
end
