module LoginSteps
  def login(email, password)
    visit(new_user_session_path)
    fill_in('Email', :with => email)
    fill_in('Password', :with => password)
    click_button('Sign in')
  end
end

World(LoginSteps)

Given /^a logged in user$/ do
  @user = FactoryGirl.create(:user, :email => 'admin@iscool.com', :password => 'pas5word', :password_confirmation => 'pas5word')
  login(@user.email, @user.password)
end

Given /^an api_key with a skill in training$/ do
  @api = FactoryGirl.create(:api_key, :skill_is_training)
end

Given /^an api_key with a skill not training$/ do
  @api = FactoryGirl.create(:api_key, :skill_not_training)
end

When /^user visits the add new character page$/ do
  visit(new_api_key_path)
end

When /^user visits their api_key show page$/ do
  visit(api_key_path(:id => 1))
end

When /^user inputs "(.*?)" as their "(.*?)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^user clicks "(.*?)"$/ do |button|
  click_button(button)
end

Then /^the user should see "(.*?)"$/ do |text|
  page.should have_text(text)
end

Then /^the user should not see "(.*?)"$/ do |text|
  page.should_not have_text(text)
end
