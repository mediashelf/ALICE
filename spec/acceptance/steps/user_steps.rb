step 'there is a user named :username' do |username|
  @user = FactoryGirl.create(:user, email: username)
end

step 'I fill in :field with :value' do |field, value|
  fill_in(field, with: value)
end
