require 'rails_helper'

RSpec.describe RecipesHelper, type: :helper do
  describe '#get_recipe_image' do
    let(:recipe) { double('Recipe', image: image) }

    context 'when recipe has an image' do
      let(:image) { 'https://example.com/image.jpg' }

      it 'returns the image URL' do
        expect(helper.get_recipe_image(recipe)).to eq(image)
      end
    end

    context 'when recipe has no image' do
      let(:image) { nil }

      it 'returns the default image path' do
        expect(helper.get_recipe_image(recipe)).to eq('default-recipe.png')
      end
    end
  end
end
