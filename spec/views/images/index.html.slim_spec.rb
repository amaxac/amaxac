require 'rails_helper'

RSpec.describe "images/index", :type => :view do
  before(:each) do
    assign(:images, [
      Image.create!(
        :link => "Link",
        :text => "Text",
        :rating => 1,
        :added_by => ""
      ),
      Image.create!(
        :link => "Link",
        :text => "Text",
        :rating => 1,
        :added_by => ""
      )
    ])
  end

  it "renders a list of images" do
    render
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Text".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
