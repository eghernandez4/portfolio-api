require 'rails_helper'

RSpec.describe ExperienceSkill, type: :model do
  let(:experience) { Experience.create!(company: 'Otto', position: 'Dev', start_date: Date.today, current: true) }
  let(:skill) { Skill.create!(name: 'Ruby') }

  describe 'associations' do
    it 'belongs to experience' do
      association = described_class.reflect_on_association(:experience)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to skill' do
      association = described_class.reflect_on_association(:skill)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with experience and skill' do
      exp_skill = ExperienceSkill.new(experience: experience, skill: skill)
      expect(exp_skill).to be_valid
    end

    it 'validates uniqueness of skill_id scoped to experience_id' do
      ExperienceSkill.create!(experience: experience, skill: skill)
      duplicate = ExperienceSkill.new(experience: experience, skill: skill)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:skill_id]).to include('has already been taken')
    end

    it 'raises a database-level error when trying to bypass validations to insert duplicate' do
      ExperienceSkill.create!(experience: experience, skill: skill)
      expect {
        ExperienceSkill.new(experience: experience, skill: skill).save(validate: false)
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end
end
