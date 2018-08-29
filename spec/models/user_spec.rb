require "rails_helper"

RSpec.describe User, :type => :model do
  describe 'FactoryBot' do
    it 'should user factory valid' do
      expect(create :user).to be_valid
    end
  end
  
  describe 'Every user should' do
    let(:user) { create :user }

    it "has a first_name" do
      expect(user.first_name).to eq("John")
    end
    it "has a last_name" do
      expect(user.last_name).to eq("Doe")
    end
    it "has a name" do
      expect(user.name).to eq("John Doe")
    end
    it "has an email" do
      expect(user.email).to eq("john@doe.com")
    end
    it "has status" do
      expect(user.role).to eq(2)
      expect(user.role_name).to eq(:normal)
    end
  end

  describe 'When updating user' do
    let(:user) { create :user }

    it 'passwords must match' do
      user.assign_attributes( password: "abc123", password_confirmation: "abc1234")
      expect(user).not_to be_valid
      expect(user.errors.messages[:password_confirmation]).to eq(["doesn't match Password"])
    end
    it 'password should have at least 6 chars' do
      user.assign_attributes(password: "abc12", password_confirmation: "abc12")
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to eq(["is too short (minimum is 6 characters)"])
    end

    it 'first_name shouldn\'t be blank' do
      user.assign_attributes(first_name: "")
      expect(user).not_to be_valid
      expect(user.errors.messages[:first_name]).to eq(["can't be blank"])
    end
    it 'last_name shouldn\'t be blank' do
      user.assign_attributes(last_name: "")
      expect(user).not_to be_valid
      expect(user.errors.messages[:last_name]).to eq(["can't be blank"])
    end
    it 'email_name shouldn\'t be blank' do
      user.assign_attributes(email: "")
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to eq(["can't be blank"])
    end
    it 'role_name shouldn\'t be blank' do
      user.assign_attributes(role: nil)
      expect(user).not_to be_valid
      expect(user.errors.messages[:role]).to eq(["can't be blank"])
    end
  end

  describe 'When creating new user' do
    let(:user) { create :user }
    
    it 'shouldn\'t allow to have the same email as exisiting user' do
      new_user_params = {first_name: "John2", last_name: "Doe2", email: user.email, password: "abc123", password_confirmation: "abc123"}
      new_user = User.new(new_user_params)
      expect(new_user.save).to eq(false)
      expect(new_user.errors.messages[:email]).to eq(["has already been taken"])
    end
  end

  describe 'User roles should translate to' do
    let(:user) { create :user }
    
    it 'inactive if role is 0' do
      user.assign_attributes(role: 0)
      expect(user.role_name).to eq(:inactive)
    end
    it 'admin if role is 1' do
      user.assign_attributes(role: 1)
      expect(user.role_name).to eq(:admin)
    end
    it 'normal if role is 2' do
      user.assign_attributes(role: 2)
      expect(user.role_name).to eq(:normal)
    end
    it 'normal if role is out of range' do
      user.assign_attributes(role: 3)
      expect(user.role_name).to eq(:normal)
    end
  end
end
