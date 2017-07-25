require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to belong_to(:postable) }
  it { is_expected.to belong_to(:user) }

end
