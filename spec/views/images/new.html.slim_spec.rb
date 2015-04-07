require 'rails_helper'

RSpec.describe "images/new", :type => :view do
  before(:each) do
    assign(:image, Image.new(
      :link => "MyString",
      :text => "MyString",
      :rating => 1,
      :added_by => ""
    ))
  end

  it "renders new image form" do
    render

    assert_select "form[action=?][method=?]", images_path, "post" do

      assert_select "input#image_link[name=?]", "image[link]"

      assert_select "input#image_text[name=?]", "image[text]"

      assert_select "input#image_rating[name=?]", "image[rating]"

      assert_select "input#image_added_by[name=?]", "image[added_by]"
    end
  end
end
