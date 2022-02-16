# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New user' do
  describe 'view' do
    it 'I see a form to register a new user' do
      visit '/register'
      fill_in 'user_name', with: 'name1'
      fill_in 'user_email', with: 'example@email.com'
      fill_in 'password', with: 'test123'
      fill_in 'password_confirmation', with: 'test123'
      click_button('Register')
      expect(current_path).to eq("/users/#{User.last.id}")
      expect(page).to have_content('name1')
    end
  end

  context 'input wrong or incomplete information' do
    scenario 'flash mesage appears when email is taken' do
      user = User.create!(name: 'lili', email: 'lili@gmail.com', password: 'test123', password_confirmation: 'test123')

      visit '/register'
      fill_in 'user_name', with: 'name1'
      fill_in 'user_email', with: 'lili@gmail.com'
      fill_in 'password', with: 'test123'
      fill_in 'password_confirmation', with: 'test123'
      click_button('Register')

      expect(page).to have_content('User Not Created: Email Taken.')
      expect(current_path).to eq('/register')
    end

    scenario 'flash message appears when not all fields are filled' do
      visit '/register'
      fill_in 'user_name', with: 'name1'
      fill_in 'user_email', with: 'lili@gmail.com'
      fill_in 'password', with: 'test123'
      click_button('Register')

      expect(page).to have_content('User Not Created: Required info missing.')
      expect(current_path).to eq('/register')
    end

    scenario 'when password and confirmation do not match flash message' do
      visit '/register'
      fill_in 'user_name', with: 'name1'
      fill_in 'user_email', with: 'lili@gmail.com'
      fill_in 'password', with: 'test123'
      fill_in 'password_confirmation', with: 'test125'
      click_button('Register')

      expect(page).to have_content('Passwords must match')
      expect(current_path).to eq('/register')
    end
  end
end
