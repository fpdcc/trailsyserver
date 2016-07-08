require 'rails_helper'

RSpec.describe "names/edit", type: :view do
  before(:each) do
    @name = assign(:name, Name.create!(
      :nameid => 1,
      :name => "MyString",
      :old_id => 1
    ))
  end

  it "renders the edit name form" do
    render

    assert_select "form[action=?][method=?]", name_path(@name), "post" do

      assert_select "input#name_nameid[name=?]", "name[nameid]"

      assert_select "input#name_name[name=?]", "name[name]"

      assert_select "input#name_old_id[name=?]", "name[old_id]"
    end
  end
end
