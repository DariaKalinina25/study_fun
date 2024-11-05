# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page' do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  context 'when the user is not signed in' do
    before { visit root_path }

    it 'displays "Sign In" link in the navbar' do
      within('nav') do
        expect(page).to have_link(I18n.t('devise.sessions.sign_in'), href: new_user_session_path)
      end
    end

    it 'does not display "Sign Out" link in the navbar' do
      within('nav') do
        expect(page).to have_no_link(I18n.t('devise.sessions.sign_out'), href: destroy_user_session_path)
      end
    end
  end

  context 'when the user is signed in' do
    before do
      sign_in(user)
      visit root_path
    end

    it 'displays "Sign Out" link in the navbar' do
      within('nav') do
        expect(page).to have_link(I18n.t('devise.sessions.sign_out'), href: destroy_user_session_path)
      end
    end

    it 'does not display "Sign In" link in the navbar' do
      within('nav') do
        expect(page).to have_no_link(I18n.t('devise.sessions.sign_in'), href: new_user_session_path)
      end
    end
  end
end
