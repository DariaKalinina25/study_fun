# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page' do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  let(:sign_in_text) { I18n.t('devise.sessions.sign_in') }
  let(:sign_out_text) { I18n.t('devise.sessions.sign_out') }

  def sign_in_and_visit_root(user)
    sign_in(user)
    visit root_path
  end

  context 'when the user is not signed in' do
    before { visit root_path }

    it { expect(page).to have_css('nav a', text: sign_in_text) }
    it { expect(page).to have_no_css('nav button', text: sign_out_text) }
  end

  context 'when the user is signed in' do
    before { sign_in_and_visit_root(user) }

    it { expect(page).to have_css('nav button', text: sign_out_text) }
    it { expect(page).to have_no_css('nav a', text: sign_in_text) }
  end

  context 'when the user is signed out' do
    before do
      sign_in_and_visit_root(user)
      click_button I18n.t('devise.sessions.sign_out')
    end

    it { expect(page).to have_current_path(root_path) }
    it { expect(page).to have_css('nav a', text: sign_in_text) }
    it { expect(page).to have_no_css('nav button', text: sign_out_text) }
  end
end
