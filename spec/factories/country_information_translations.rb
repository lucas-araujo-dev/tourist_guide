FactoryBot.define do
  factory :country_information_translation do
    language { 'en' }
    translation do
      'Brazil is a country in South America. Its capital is Brasília. The population is 206135893. The area is 8515767 square kilometers. The currency is Brazilian real. The language is Portuguese. The flag: https://restcountries.com/data/bra.svg.'
    end
    country_information
  end
end
