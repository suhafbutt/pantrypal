require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:recipes).with_foreign_key('author_id') }
  end
end
