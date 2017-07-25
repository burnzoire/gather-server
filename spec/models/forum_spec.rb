require 'rails_helper'

RSpec.describe Forum, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to belong_to(:organisation) }
  it { is_expected.to have_many(:topics) }
end
