# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { build(:user) }

    # Validation of email presence and uniqueness
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    # Validation for correct email
    it { is_expected.to allow_value('user@example.com').for(:email) }

    # Validation for invalid email
    invalid_emails = ['invalid_email', 'user@.com', '@domain.com', 'user@domain..com']

    invalid_emails.each do |invalid_email|
      it { is_expected.not_to allow_value(invalid_email).for(:email) }
    end

    # Validation for presence, uniqueness and length
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end
end
