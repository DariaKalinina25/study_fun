# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Authentication' do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  def fill_authentication_form(email, password)
    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
  end

  it 'user authentication with correct data' do
    fill_authentication_form(user.email, user.password)

    click_link_or_button 'Log in'

    expect(page).to have_content 'Signed in successfully'
  end

  it 'user authentication with incorrect password' do
    fill_authentication_form(user.email, 'incorrect_password')

    click_link_or_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end
