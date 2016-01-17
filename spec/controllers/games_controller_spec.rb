require 'rails_helper'
require 'devise'

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

RSpec.describe GamesController, type: :controller do
  
 	describe "Create a new game when logged in" do
#		@user = FactoryGirl.create(:user)
      
        before(:each) do
          #puts "Users: #{User.select(:email).to_a}"
          user = FactoryGirl.create(:user)
		  sign_in user
		end
      
		it "creates a new game" do
			expect{get :create}.to change{Game.count}.by(1)
		end

		it "redirects to the Games index page" do
			get :create
			expect(response).to redirect_to(games_path)
		end
 	end

 	describe "View games and join an open one" do 
# 		user = FactoryGirl.create(:user)
 		
 		before(:each) do
 		    user = FactoryGirl.create(:user)          
			sign_in user
		end
 		
 		it "can render the games page if logged in" do
 			get :index
 			expect(response).to have_http_status(200)
 		end

 		it "can join an open game" do
 			
 		end

 	end
 	

end
