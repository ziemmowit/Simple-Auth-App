require "rails_helper"

describe "Public access to homepage", type: :request do
  it "renders home page to every user" do
    get root_path
    expect(response).to have_http_status(200)
  end
end

describe "Public access to", type: :request do
  it "user edit page is denied" do
    #get edit_user_registration_path
    get '/users/edit'
    expect(response).to redirect_to new_user_session_path
  end
  it "user update action is denied" do
    patch user_registration_path
    expect(response).to redirect_to new_user_session_path
  end
end

describe "Authentications:", type: :request do
  let(:user) { create :user }
  
  it "login and logout" do
    sign_in user
    get root_path
    expect(controller.current_user).to eq(user)
    
    sign_out user
    get root_path
    expect(controller.current_user).to be_nil
  end
end

describe "User password reset" do
  it "is allowed through reset form", type: :request do
    get new_user_password_path
    expect(response).to have_http_status(200)
  end

  it 'is not allowed for user already logged in'
end
