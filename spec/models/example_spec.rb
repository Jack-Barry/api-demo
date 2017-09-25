require 'rails_helper'

RSpec.describe Example, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:content) }
end
