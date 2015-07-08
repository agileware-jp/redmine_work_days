FactoryGirl.define do 
  factory :user do
    login "admin"
    hashed_password "9e4dd7eeb172c12a0691a6d9d3a269f7e9fe671b"
    firstname "Redmine"
    lastname "Admin"
    admin true
    status 1
    last_login_on Time.zone.now
    language "ja"
    auth_source_id 1
    created_on Time.zone.now
    updated_on Time.zone.now
    type "User"
    identity_url "http://"
    mail_notification "all"
    salt "3126f764c3c5ac61cbfc103f25f934cf"
    must_change_passwd false
    passwd_changed_on Time.zone.now
    mail "test@test.com"
  end 
end 