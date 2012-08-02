def path_to(page_name)
  case page_name
  when 'home' then '/'
  when 'sign in' then '/users/sign_in'
  else raise("Please add the #{page_name} path to features/support/paths.rb")
  end
end
