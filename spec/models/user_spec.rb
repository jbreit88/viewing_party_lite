# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_parties) }
    it { should have_many(:parties).through(:user_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:password_digest)}
    it { should have_secure_password}
    it 'does not save password to database' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
      
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end

  describe 'factory object' do
    it 'should build a valid user object' do
      user = build(:user, email: 'fake_email@gmail.com', name: 'fake name')

      expect(user).to be_a(User)
      expect(user.email).to eq('fake_email@gmail.com')
      expect(user.name).to eq('fake name')
    end
  end
end
