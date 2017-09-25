FactoryGirl.define do
  factory :example do
    name    { Faker::TwinPeaks.character }
    content { Faker::TwinPeaks.quote }
  end
end
