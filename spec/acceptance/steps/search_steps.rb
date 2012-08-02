step 'an empty Solr index' do
  (1..10).each { |id| @rsolr.delete_by_id(id) }
  @rsolr.commit
  num_indexed.should == 0
end

step 'an open Solr connection' do
  @rsolr ||= RSolr.connect(:url => 'http://localhost:8983/solr')
  @id_sequence = 1
end

step 'asset :title with :content' do |title, content|
  @id_sequence += 1

  @rsolr.add(
    id: @id_sequence,
    title_t: title,
    content_t: content
  )

  @rsolr.commit
end

step 'there should be :num assets' do |num|
  num_indexed.should == num.to_i
end

step 'I fill in :field with :value' do |field, value|
  fill_in(field, with: value)
end

step 'I click :button' do |button|
  click_on(button)
end

step 'I search for :content' do |content|
  fill_in('q', with: content)
  click_on('search')
end

step 'I should see :text' do |text|
  page.should have_content(text)
end
