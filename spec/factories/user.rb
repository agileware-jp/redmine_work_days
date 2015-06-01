FactoryGirl.define do
  factory :user do
    status 1
    language 'en'
    hashed_password 'b5b6ff9543bf1387374cdfa27a54c96d236a7150'
    admin 1
    mail 'admin@somenet.foo'
    lastname 'Admin'
    firstname 'Redmine'
    id 1
    mail_notification 'all'
    login 'admin1'
    type User
  end
end
