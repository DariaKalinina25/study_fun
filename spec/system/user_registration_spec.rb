# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration' do
  before do
    driven_by(:rack_test)
  end

  let(:user) { build(:user) }

  def fill_registration_form(email, password, password_confirmation)
    visit new_user_registration_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
  end

  context 'when the user has entered correct data' do
    it 'shows a message about successful registration' do
      fill_registration_form(user.email, user.password, user.password)

      click_link_or_button 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
  end

  context 'when the user entered an existing email' do
    it 'shows an error message' do
      user.save!
      fill_registration_form(user.email, user.password, user.password)

      click_link_or_button 'Sign up'

      expect(page).to have_content 'Email has already been taken'
    end
  end

  context 'when the user entered an incorrect confirmation password' do
    it 'shows an error message' do
      fill_registration_form(user.email, user.password, 'incorrect_password')

      click_link_or_button 'Sign up'

      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end
