FactoryGirl.define do  

	factory :user do
		sequence :email do |n|
          "testing_email#{n}@email.com"
		end
		password "pswrd12345678"
		password_confirmation "pswrd12345678"
	end

end