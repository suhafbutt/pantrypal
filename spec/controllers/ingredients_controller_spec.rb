require 'rails_helper'

RSpec.describe IngredientsController, type: :request do
  describe 'GET /ingredients' do
    before do
      create(:ingredient, name: 'Salt')
      create(:ingredient, name: 'Sugar')
      create(:ingredient, name: 'Butter')
    end

    it 'returns matching ingredient names for a query' do
      get ingredients_path, params: { query: 's' }
      parsed_response = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_response).to include('Salt', 'Sugar')
      expect(parsed_response).not_to include('Butter')
    end

    it 'is case-insensitive' do
      get ingredients_path, params: { query: 'SALT' }
      parsed_response = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_response).to include('Salt')
    end

    it 'returns an empty array if no match found' do
      get ingredients_path, params: { query: 'xyz' }
      parsed_response = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(parsed_response).to eq([])
    end
  end
end
