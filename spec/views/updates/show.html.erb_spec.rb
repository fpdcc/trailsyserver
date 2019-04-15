require 'rails_helper'

RSpec.describe "updates/show", type: :view do
  before(:each) do
    @update = assign(:update, Update.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
