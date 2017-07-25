FactoryGirl.define do
  factory :message do
    content 'lorem ipsum dol sit amet'
    association :postable, factory: :topic
  end
end
