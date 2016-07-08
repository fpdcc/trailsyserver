require 'rails_helper'

RSpec.describe "names/new", type: :view do
  before(:each) do
    assign(:name, Name.new(
      :nameid => 1,
      :name => "MyString",
      :old_id => 1
    ))
  end

  it "renders new name form" do
    render

    assert_select "form[action=?][method=?]", names_path, "post" do

      assert_select "input#name_nameid[name=?]", "name[nameid]"

      assert_select "input#name_name[name=?]", "name[name]"

      assert_select "input#name_old_id[name=?]", "name[old_id]"
    end
  end
end
