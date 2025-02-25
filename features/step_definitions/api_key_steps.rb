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

When /^user visits the add new character page$/ do
  visit(new_api_key_path)
end

When /^user inputs "(.*?)" as their "(.*?)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^user clicks "(.*?)"$/ do |button|
  click_button(button)
end

Then /^user should be presented with "(.*?)" as their "(.*?)"$/ do |value, field|
  page.has_field?(field, :with => value)
end

Then /^the user should see "(.*?)"$/ do |text|
  page.should have_text(text)
end