# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CountryInformationTranslation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:country_information) }
  end
end
