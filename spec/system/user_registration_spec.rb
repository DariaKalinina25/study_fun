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

  it 'user registration with correct data' do
    fill_registration_form(user.email, user.password, user.password)

    click_link_or_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'user registration with existing email' do
    user.save!
    fill_registration_form(user.email, user.password, user.password)

    click_link_or_button 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  it 'user registration with incorrect confirmation password' do
    fill_registration_form(user.email, user.password, 'incorrect_password')

    click_link_or_button 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end
end
