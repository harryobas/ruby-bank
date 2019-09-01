FactoryBot.define do
  factory :user, class: User do
    password_digest { "MyString" }
    email {"friend@mail.com"}
    password {"pa$$word"}
  end
end
