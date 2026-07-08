require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    it 'is valid with name and headline' do
      profile = Profile.new(name: 'Eduar Hernández', headline: 'Senior Ruby Developer')
      expect(profile).to be_valid
    end

    it 'is invalid without a name' do
      profile = Profile.new(name: nil, headline: 'Senior Ruby Developer')
      expect(profile).not_to be_valid
      expect(profile.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a headline' do
      profile = Profile.new(name: 'Eduar', headline: nil)
      expect(profile).not_to be_valid
      expect(profile.errors[:headline]).to include("can't be blank")
    end

    it 'is valid with correct email format' do
      profile = Profile.new(name: 'Eduar', headline: 'Dev', email: 'test@example.com')
      expect(profile).to be_valid
    end

    it 'is invalid with incorrect email format' do
      profile = Profile.new(name: 'Eduar', headline: 'Dev', email: 'invalid-email')
      expect(profile).not_to be_valid
      expect(profile.errors[:email]).to include('is invalid')
    end
  end

  describe 'singleton rule' do
    before do
      Profile.create!(name: 'Eduar Hernández', headline: 'Senior Ruby Developer')
    end

    it 'does not allow creating a second profile' do
      second_profile = Profile.new(name: 'Another', headline: 'Another Dev')
      expect(second_profile).not_to be_valid
      expect(second_profile.errors[:base]).to include('Only one profile is allowed in the system')
    end

    it 'raises a database-level error when trying to bypass validations to insert a second profile' do
      expect {
        Profile.new(name: 'Another', headline: 'Another Dev').save(validate: false)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
