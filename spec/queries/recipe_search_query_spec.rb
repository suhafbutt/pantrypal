require 'rails_helper'

RSpec.describe RecipeSearchQuery, type: :service do
  let!(:ingredient1) { create(:ingredient, name: "salt") }
  let!(:ingredient2) { create(:ingredient, name: "sugar") }
  let!(:ingredient3) { create(:ingredient, name: "flour") }

  let!(:recipe1) { create(:recipe, title: "Salted Bread", prep_time: 10, cook_time: 20, ratings: 4.5, ingredients: [ ingredient1 ]) }
  let!(:recipe2) { create(:recipe, title: "Sweet Cake", prep_time: 15, cook_time: 30, ratings: 4.8, ingredients: [ ingredient2 ]) }
  let!(:recipe3) { create(:recipe, title: "Plain Flour Bread", prep_time: 20, cook_time: 25, ratings: 3.8, ingredients: [ ingredient3 ]) }

  let(:page_number) { 1 }
  let(:per_page) { 10 }

  context "when filtering by included_ingredients" do
    it "returns recipes with matching ingredients" do
      results = described_class.new(search_params: { included_ingredients: "salt" }, page_number: page_number, per_page: per_page).filter
      expect(results).to contain_exactly(recipe1)
    end
  end

  context "when filtering by excluded_ingredients" do
    it "excludes recipes with matching ingredients" do
      results = described_class.new(search_params: { excluded_ingredients: "salt" }, page_number: page_number, per_page: per_page).filter
      expect(results).to match_array([ recipe2, recipe3 ])
    end
  end

  context "when filtering by recipe_title" do
    it "returns recipes with matching title" do
      results = described_class.new(search_params: { recipe_title: "cake" }, page_number: page_number, per_page: per_page).filter
      expect(results).to contain_exactly(recipe2)
    end
  end

  context "when filtering by prep_time" do
    it "returns recipes with prep_time less than or equal to given value" do
      results = described_class.new(search_params: { prep_time: 15 }, page_number: page_number, per_page: per_page).filter
      expect(results).to contain_exactly(recipe1, recipe2)
    end
  end

  context "when filtering by cook_time" do
    it "returns recipes with cook_time less than or equal to given value" do
      results = described_class.new(search_params: { cook_time: 25 }, page_number: page_number, per_page: per_page).filter
      expect(results).to contain_exactly(recipe1, recipe3)
    end
  end

  context "when filtering by ratings" do
    it "returns recipes with rating greater than or equal to given value" do
      results = described_class.new(search_params: { ratings: 4.5 }, page_number: page_number, per_page: per_page).filter
      expect(results).to contain_exactly(recipe1, recipe2)
    end
  end

  context "when using multiple filters together" do
    it "applies all filters correctly" do
      results = described_class.new(search_params: {
        included_ingredients: "salt",
        prep_time: 15,
        ratings: 4.0
      }, page_number: page_number, per_page: per_page).filter

      expect(results).to contain_exactly(recipe1)
    end
  end
end
