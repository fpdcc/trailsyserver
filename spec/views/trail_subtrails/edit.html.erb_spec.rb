require 'rails_helper'

RSpec.describe "trail_subtrails/edit", type: :view do
  before(:each) do
    @trail_subtrail = assign(:trail_subtrail, TrailSubtrail.create!())
  end

  it "renders the edit trail_subtrail form" do
    render

    assert_select "form[action=?][method=?]", trail_subtrail_path(@trail_subtrail), "post" do
    end
  end
end
