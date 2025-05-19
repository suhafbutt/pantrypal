require 'rails_helper'

RSpec.describe "Recipe index", type: :feature do
  let!(:flour) { Ingredient.create!(name: "flour") }
  let!(:egg)   { Ingredient.create!(name: "egg") }

  let!(:recipe1) { Recipe.create!(title: "Banana Bread", prep_time: 10, cook_time: 20, ratings: 4.5) }
  let!(:recipe2) { Recipe.create!(title: "Pancakes", prep_time: 5, cook_time: 10, ratings: 4.0) }

  before do
    recipe1.ingredients << flour
    recipe2.ingredients << egg
    visit recipes_path
  end

  scenario "user sees the search form" do
    expect(page).to have_selector("form")
    expect(page).to have_content("Search Recipes")
    expect(page).to have_content("Advance filters")
  end

  scenario "user searches for a recipe by title" do
    fill_in "recipe_title", with: "Banana"
    click_button "Search"
    expect(page).to have_content("Banana Bread")
    expect(page).not_to have_content("Pancakes")
  end

  scenario "user filters by Ingredients you have" do
    fill_in "included_ingredients", with: "egg"
    click_button "Search"
    expect(page).to have_content("Pancakes")
    expect(page).not_to have_content("Banana Bread")
  end

  scenario "user filters by Ingredients you don't have" do
    fill_in "excluded_ingredients", with: "egg"
    click_button "Search"
    expect(page).to have_content("Banana Bread")
    expect(page).not_to have_content("Pancakes")
  end

  scenario "user filters by Ingredients you don't have" do
    fill_in "excluded_ingredients", with: "egg"
    click_button "Search"
    expect(page).to have_content("Banana Bread")
    expect(page).not_to have_content("Pancakes")
  end

  scenario "User clicks on a specific recipe link and navigates to the recipe page" do
    click_link "Banana Bread"
    expect(current_path).to eq(recipe_path(recipe1))
    expect(page).to have_content("Banana Bread")
  end
end
