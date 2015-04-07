require 'rails_helper'

RSpec.describe "images/edit", :type => :view do
  before(:each) do
    @image = assign(:image, Image.create!(
      :link => "MyString",
      :text => "MyString",
      :rating => 1,
      :added_by => ""
    ))
  end

  it "renders the edit image form" do
    render

    assert_select "form[action=?][method=?]", image_path(@image), "post" do

      assert_select "input#image_link[name=?]", "image[link]"

      assert_select "input#image_text[name=?]", "image[text]"

      assert_select "input#image_rating[name=?]", "image[rating]"

      assert_select "input#image_added_by[name=?]", "image[added_by]"
    end
  end
end
