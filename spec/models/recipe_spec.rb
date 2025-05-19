require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it { should belong_to(:category).optional }
    it { should belong_to(:cuisine).optional }
    it { should belong_to(:author).class_name('User').optional }
    it { should have_many(:recipe_ingredients).dependent(:destroy) }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
  end

  describe 'validations' do
    subject { create(:recipe) }

    it { should validate_presence_of(:title) }
    it { should validate_numericality_of(:prep_time).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:cook_time).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:ratings).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5).allow_nil }
  end
end
