FactoryGirl.define do
  factory :rest_day_right, class: RestDay do
    id 1
    day Date.parse('2015-05-13')
    description 'testdata'
  end
end
