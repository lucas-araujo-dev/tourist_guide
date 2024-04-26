FactoryBot.define do
  factory :country_information do
    country_name { 'Brazil' }
    original_response { { 'name' => { 'common' => 'Brazil' } } }
  end
end
