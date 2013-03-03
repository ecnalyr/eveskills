module LoginSteps
  def login(email, password)
    visit(user_login_path)
    fill_in('Email', :with => email)
    fill_in('Passsword', :with => password)
    click_button('Sign In')
  end
end

World(LoginSteps)

Given /^a logged in user$/ do
  @user = FactoryGirl.create(:email => 'admin@iscool.com', :password => 'pas5word')
  login(@user.email @user.password)
end

When /^user visits the add new character page$/ do
  visit(api_key_create_path)
end