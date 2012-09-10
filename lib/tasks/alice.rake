desc "reindex"
task :reindex => :environment do
  Asset.all.each {|m| m.index_record}
  Blacklight.solr.optimize
end
