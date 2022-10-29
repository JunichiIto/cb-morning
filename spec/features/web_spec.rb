require 'rails_helper'

feature "web" do
  before do
    MenuItem.destroy_all
    Category.destroy_all
    Tag.destroy_all
  end

  scenario "save and view" do
    visit root_path
    expect(page).to have_content "CB Morning"

    click_link "New Category"
    fill_in "Name", with: "菓子パン"
    fill_in "Position", with: 1
    click_button "Create Category"
    expect(page).to have_content "Category Was Successfully Created"

    click_link "Menu Items"
    click_link "New Menu item"
    fill_in "Name", with: "あんぱん"
    select "菓子パン", from: "Category"
    fill_in "Keyword list", with: "あんこ,こしあん"
    click_button "Create Menu item"
    expect(page).to have_content "Menu Item Was Successfully Created"

    click_link "Back"
    expect(page).to have_content "菓子パン"
    expect(page).to have_content "あんぱん"
    expect(page).to have_content "あんこ"
    expect(page).to have_content "こしあん"

    click_link "CB Morning"
    expect(page).to have_content "菓子パン"
    expect(page).to have_content "あんぱん"
  end
end
