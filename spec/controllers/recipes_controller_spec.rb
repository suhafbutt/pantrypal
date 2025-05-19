require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  describe 'GET /recipes' do
    let!(:recipe1) { create(:recipe, title: 'Chocolate Cake', ratings: 4.5) }
    let!(:recipe2) { create(:recipe, title: 'Banana Bread', ratings: 4.0) }

    it 'returns a successful response for HTML' do
      get recipes_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Chocolate Cake', 'Banana Bread')
    end

    it 'filters by recipe_title' do
      get recipes_path, params: { recipe_title: 'chocolate' }
      expect(response.body).to include('Chocolate Cake')
      expect(response.body).not_to include('Banana Bread')
    end

    it 'responds to turbo_stream format' do
      get recipes_path, headers: { 'ACCEPT' => 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq('text/vnd.turbo-stream.html')
    end
  end

  describe 'GET /recipes/:id' do
    context 'when recipe exists' do
      let!(:recipe) { create(:recipe) }
      let!(:ingredient) { create(:ingredient, name: 'flour') }
      let!(:recipe_ingredient) { create(:recipe_ingredient, recipe: recipe, ingredient: ingredient) }

      it 'returns a successful response' do
        get recipe_path(recipe)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('flour')
      end
    end

    context 'when recipe does not exist' do
      it 'redirects to index with alert' do
        get recipe_path(id: 9999)
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
end
