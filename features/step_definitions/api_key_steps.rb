module LoginSteps
  def login(email, password)
    visit('users/sign_in')
    fill_in('Email', :with => email)
    fill_in('Passsword', :with => password)
    click_button('Sign In')
  end
end

World(LoginSteps)

Given /^a logged in user$/ do
  @user = FactoryGirl.create(:user, :email => 'admin@iscool.com', :password => 'pas5word', :password_confirmation => 'pas5word')
  login(@user.email, @user.password)
end

When /^user visits the add new character page$/ do
  visit(api_key_create_path)
end