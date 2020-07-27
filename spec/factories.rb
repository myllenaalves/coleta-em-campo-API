FactoryBot.define do
  factory :user do
    id { 2 }
    email { 'columbus_bahringer@robel-bednar.io' }
    cpf  {'01070681504'}
    password {'poliglota90'}
    name { "Test user" }
  end
end

FactoryBot.define do
  factory :question do
    id { 2 }
    name {'Test question 1'}
    formulary_id { 2 }
    question_type {'ifahoifh'}
  end
end

FactoryBot.define do
  factory :formulary do
    id { 2 }
    name { "Test formulary 1" }
  end
end

FactoryBot.define do
  factory :visit do
    id { 2 }
    date { '2020-08-26 11:59:02.202929584 -0300' }
    checkin_at { '2020-05-26 12:59:02.202929584 -0300' }
    checkout_at  {'2020-08-26 15:59:02.202929584 -0300'}
    status {'Realizado'}
    user_id { 2 }
  end
end

FactoryBot.define do
  factory :answer do
    id { 2 }
    content { "Test answer 1" }
    question_id { 2 }
    formulary_id { 2 }
    visit_id { 2 }
  end
end
