FactoryGirl.define do
  factory :rest_day_right, class: RestDay do
    day Date.parse('2015-05-13')
    description 'testdata'
  end
end
