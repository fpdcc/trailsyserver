require 'rails_helper'

RSpec.describe "updates/index", type: :view do
  before(:each) do
    assign(:updates, [
      Update.create!(),
      Update.create!()
    ])
  end

  it "renders a list of updates" do
    render
  end
end
