require 'rails_helper'

RSpec.describe "updates/new", type: :view do
  before(:each) do
    assign(:update, Update.new())
  end

  it "renders new update form" do
    render

    assert_select "form[action=?][method=?]", updates_path, "post" do
    end
  end
end
