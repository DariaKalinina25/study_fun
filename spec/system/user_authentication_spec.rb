# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Authentication' do
  let(:user) { create(:user) }

  def fill_authentication_form(email, password)
    visit new_user_session_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_button I18n.t('devise.sessions.sign_in')
  end

  context 'when the user has entered correct data' do
    before { fill_authentication_form(user.email, user.password) }

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_content I18n.t('devise.sessions.signed_in') }
  end

  context 'when the user entered an incorrect email' do
    before { fill_authentication_form('incorrect email', user.password) }

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_content I18n.t('devise.failure.invalid') }
  end

  context 'when the user entered an incorrect password' do
    before { fill_authentication_form(user.email, 'incorrect_password') }

    it { expect(page).to have_current_path(new_user_session_path) }
    it { expect(page).to have_content I18n.t('devise.failure.invalid') }
  end
end
