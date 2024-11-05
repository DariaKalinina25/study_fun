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

    click_button I18n.t('devise.sessions.sign_in')
  end

  context 'when the user has entered correct data' do
    it 'shows a successful sign-in message' do
      fill_authentication_form(user.email, user.password)

      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
    end
  end

  context 'when the user entered an incorrect password' do
    it 'shows an error message' do
      fill_authentication_form(user.email, 'incorrect_password')

      expect(page).to have_content(I18n.t('devise.failure.invalid'))
    end
  end
end
