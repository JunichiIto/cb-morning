require 'spec_helper'

feature "web" do
  scenario "save and view" do
    visit root_path
    expect(page).to have_content "CB Morning"
  end
end