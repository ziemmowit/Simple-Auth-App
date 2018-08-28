require "rails_helper"

RSpec.describe User, :type => :model do
	it "has a name" do
		user = User.create!(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: "abc123", password_confirmation: "abc123")
		expect(user.name).to eq("John Doe")
	end
end
