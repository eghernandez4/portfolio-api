require 'rails_helper'

RSpec.describe Experience, type: :model do
  describe 'associations' do
    it 'has many projects' do
      association = described_class.reflect_on_association(:projects)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many achievements' do
      association = described_class.reflect_on_association(:achievements)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many experience_skills' do
      association = described_class.reflect_on_association(:experience_skills)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many skills through experience_skills' do
      association = described_class.reflect_on_association(:skills)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:experience_skills)
    end
  end

  describe 'validations' do
    it 'is valid with company, position, start_date and display_order' do
      exp = build(:experience, :current, company: 'Otto', position: 'Senior Ruby Developer', start_date: Date.today - 1.year, display_order: 1)
      expect(exp).to be_valid
    end

    it 'is invalid without company' do
      exp = build(:experience, :current, company: nil, position: 'Developer', start_date: Date.today)
      expect(exp).not_to be_valid
      expect(exp.errors[:company]).to include("can't be blank")
    end

    it 'is invalid without position' do
      exp = build(:experience, :current, company: 'Otto', position: nil, start_date: Date.today)
      expect(exp).not_to be_valid
      expect(exp.errors[:position]).to include("can't be blank")
    end

    it 'is invalid without start_date' do
      exp = build(:experience, :current, company: 'Otto', position: 'Dev', start_date: nil)
      expect(exp).not_to be_valid
      expect(exp.errors[:start_date]).to include("can't be blank")
    end

    it 'is invalid with non-integer display_order' do
      exp = build(:experience, :current, company: 'Otto', position: 'Dev', start_date: Date.today, display_order: 1.5)
      expect(exp).not_to be_valid
    end

    it 'is invalid with negative display_order' do
      exp = build(:experience, :current, company: 'Otto', position: 'Dev', start_date: Date.today, display_order: -1)
      expect(exp).not_to be_valid
    end

    it 'validates inclusion of employment_type' do
      exp = build(:experience, :current, company: 'Otto', position: 'Dev', start_date: Date.today, employment_type: 'invalid')
      expect(exp).not_to be_valid
      expect(exp.errors[:employment_type]).to include('is not included in the list')
    end
  end

  describe 'callbacks and custom validations' do
    it 'clears end_date if current is true' do
      exp = build(:experience, company: 'Otto', position: 'Dev', start_date: Date.today - 1.year, end_date: Date.today, current: true)
      exp.valid?
      expect(exp.end_date).to be_nil
    end

    it 'validates end_date is after start_date' do
      exp = build(:experience, company: 'Otto', position: 'Dev', start_date: Date.today, end_date: Date.today - 1.day, current: false)
      expect(exp).not_to be_valid
      expect(exp.errors[:end_date]).to include('must be after start date')
    end

    it 'validates end_date presence if current is false' do
      exp = build(:experience, company: 'Otto', position: 'Dev', start_date: Date.today - 1.year, end_date: nil, current: false)
      expect(exp).not_to be_valid
      expect(exp.errors[:end_date]).to include('must be present if it is not the current job')
    end
  end
end
