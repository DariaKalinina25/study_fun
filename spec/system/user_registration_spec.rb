# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration' do
  let(:user) { build(:user) }

  def fill_registration_form(email, password, password_confirmation)
    visit new_user_registration_path

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation

    click_button I18n.t('devise.registrations.sign_up')
  end

  context 'when the user has entered correct data' do
    before { fill_registration_form(user.email, user.password, user.password) }

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_content I18n.t('devise.registrations.signed_up') }
  end

  context 'when the user entered an existing email' do
    before do
      driven_by(:selenium_chrome_headless)
      user.save!
      fill_registration_form(user.email, user.password, user.password)
    end

    it { expect(page).to have_current_path(new_user_registration_path) }
    it { expect(page).to have_content "Email #{I18n.t('errors.messages.taken')}" }
  end

  context 'when the user entered an incorrect confirmation password' do
    before do
      driven_by(:selenium_chrome_headless)
      fill_registration_form(user.email, user.password, 'incorrect_password')
    end

    it { expect(page).to have_current_path(new_user_registration_path) }
    it { expect(page).to have_content "Password confirmation #{I18n.t('errors.messages.confirmation')}" }
  end
end
