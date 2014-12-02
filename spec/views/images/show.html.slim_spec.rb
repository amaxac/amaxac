require 'rails_helper'

RSpec.describe "images/show", :type => :view do
  before(:each) do
    @image = assign(:image, Image.create!(
      :link => "Link",
      :text => "Text",
      :rating => 1,
      :added_by => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
