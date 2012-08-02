def num_indexed
  @rsolr.get('select')['response']['numFound']
end
