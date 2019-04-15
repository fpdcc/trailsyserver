require 'rails_helper'

RSpec.describe "updates/edit", type: :view do
  before(:each) do
    @update = assign(:update, Update.create!())
  end

  it "renders the edit update form" do
    render

    assert_select "form[action=?][method=?]", update_path(@update), "post" do
    end
  end
end
