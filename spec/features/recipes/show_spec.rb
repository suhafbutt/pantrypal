require 'rails_helper'

RSpec.describe "Recipe show", type: :feature do
  let!(:flour) { Ingredient.create!(name: "flour") }
  let!(:egg)   { Ingredient.create!(name: "egg") }

  let!(:recipe1) { Recipe.create!(title: "Banana Bread", prep_time: 10, cook_time: 20, ratings: 4.5, image: 'https://example.com/banana_bread_image.jpg') }
  let!(:recipe2) { Recipe.create!(title: "Pancakes", prep_time: 5, cook_time: 10, ratings: 4.0, image: 'https://example.com/pancakes_image.jpg') }

  before do
    recipe1.ingredients << flour
    visit recipe_path(recipe1)
  end

  scenario "user sees the title and the recipe image" do
    expect(page).to have_content("Banana Bread")
    expect(page).not_to have_content("Pancakes")
    expect(page).to have_selector('img[src="https://example.com/banana_bread_image.jpg"]')
  end

  scenario "use sees the ingredients" do
    expect(page).to have_content("Ingredients")
    expect(page).to have_content("flour")
    expect(page).not_to have_content("egg")
  end

  scenario "User navigates back to the recipes page" do
    click_link "← Back to recipes"
    expect(current_path).to eq(recipes_path)
    expect(page).to have_content("Pancakes")
    expect(page).to have_selector('img[src="https://example.com/pancakes_image.jpg"]')
    expect(page).to have_content("Banana Bread")
    expect(page).to have_selector('img[src="https://example.com/banana_bread_image.jpg"]')
  end
end
