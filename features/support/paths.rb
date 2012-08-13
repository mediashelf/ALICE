def path_to(page_name)
  case page_name
  when 'home' then '/'
  when 'new asset' then '/assets/new'
  when 'policy areas' then '/policy_areas'
  when 'sign in' then '/users/sign_in'
  when 'sub areas' then '/sub_areas'
  when 'topics' then '/topics'
  else raise("Please add the #{page_name} path to features/support/paths.rb")
  end
end
