# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include BlacklightFacetExtras::Multiple::ControllerExtension

  expose(:home_page) { Page.default_home_page }

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = {
      :qt => 'standard',
      :rows => 10,
      :'q.alt' => '*:*',
      :'f.format_sms.facet.sort' => 'index',
      :'f.level_sms.facet.sort' => 'index',
      :'f.policy_area_facet.facet.sort' => 'index',
      :'f.source_ss.facet.sort' => 'index',
      :'f.state_sms.facet.sort' => 'index',
      :'f.sub_area_facet.facet.sort' => 'index',
      :'f.topic_facet.facet.sort' => 'index',
      :'f.type_of_sms.facet.sort' => 'index',
      :'f.year_is.facet.sort' => 'index'
    }

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}'
    #}

    # solr field configuration for search results/index views
    config.index.show_link = 'title_texts'
    config.add_index_field 'topic_texts', label: 'Topic:'
    config.add_index_field 'year_is', label: 'Year:'
    config.add_index_field 'source_ss', label: 'Source:'
    config.add_index_field 'summary_texts', label: 'Summary:'

    # Future field for use with browsing functionality
    # config.index.record_display_type = 'format'

    # solr field configuration for document/show views
    config.show.html_title = 'topic_ss'
    config.show.heading = 'title_display'
    config.add_show_field 'short_title_texts', label: 'Short Title:'
    config.add_show_field 'summary_texts', label: 'Summary:'
    config.add_show_field 'topic_texts', label: 'Topic:'
    config.add_show_field 'year_is', label: 'Year:'
    config.add_show_field 'source_ss', label: 'Source:'
    config.add_show_field 'source_website_display', label: 'Source Website:'
    config.add_show_field 'bill_number_texts', label: 'Bill Number:'
    config.add_show_field 'legislative_history_display', label: 'Legislative History:'
    config.add_show_field 'state_sms', label: 'State:'
    config.add_show_field 'format_sms', label: 'Format:'
    config.add_show_field 'level_sms', label: 'Level:'
    config.add_show_field 'type_of_sms', label: 'Type:'
    config.add_show_field 'policy_area_texts', label: 'Policy Area:'
    config.add_show_field 'sub_area_texts', label: 'Sub-Area:'
    config.add_show_field 'alternative_terms_texts', label: 'Alternative Terms:'

    # Not included in initial bulk import:
    #config.add_show_field 'external_link_to_asset_display', label: 'External Link to Asset:'

    # Never to be shown to public users:
    #config.add_show_field 'notes_display', label: 'Notes:'

    # Future field for use with browsing functionality
    # config.show.display_type = 'format'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    config.add_facet_field 'policy_area_facet', label: 'Policy Area', limit: 20
    config.add_facet_field 'sub_area_facet', label: 'Sub Area', limit: 20
    config.add_facet_field 'topic_facet', label: 'Topic', limit: 20
    config.add_facet_field 'year_is', label: 'Year', limit: 20, range: true
    config.add_facet_field 'source_ss', label: 'Source', limit: 20, multiple: true
    config.add_facet_field 'state_sms', label: 'State', limit: 20, multiple: true
    config.add_facet_field 'format_sms', label: 'Format', limit: 20, multiple: true
    config.add_facet_field 'level_sms', label: 'Level', limit: 20, multiple: true
    config.add_facet_field 'type_of_sms', label: 'Type', limit: 20, multiple: true

    # Future field for use with browsing functionality
    #config.add_facet_field 'format', :label => 'Format'

    # Additional facet_field options
    #config.add_facet_field 'subject_topic_facet', :label => 'Topic', :limit => 20
    #config.add_facet_field 'language_facet', :label => 'Language', :limit => true

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys
    #use this instead if you don't want to query facets marked :show=>false
    #config.default_solr_params[:'facet.field'] = config.facet_fields.select{ |k, v| v[:show] != false}.keys

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    #config.add_search_field 'all_fields', :label => 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

#    config.add_search_field('title') do |field|
#      # solr_parameters hash are sent to Solr as ordinary url query params.
#      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }
#
#      # :solr_local_parameters will be sent using Solr LocalParams
#      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
#      # Solr parameter de-referencing like $title_qf.
#      # See: http://wiki.apache.org/solr/LocalParams
#      field.solr_local_parameters = {
#        :qf => '$title_qf',
#        :pf => '$title_pf'
#      }
#    end

    #config.add_search_field('author') do |field|
      #field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
      #field.solr_local_parameters = {
        #:qf => '$author_qf',
        #:pf => '$author_pf'
      #}
    #end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    #config.add_search_field('subject') do |field|
      #field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
      #field.qt = 'search'
      #field.solr_local_parameters = {
        #:qf => '$subject_qf',
        #:pf => '$subject_pf'
      #}
    #end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    #config.add_sort_field 'score desc, pub_date_sort desc, title_sort asc', :label => 'relevance'
    #config.add_sort_field 'pub_date_sort desc, title_sort asc', :label => 'year'
    #config.add_sort_field 'author_sort asc, title_sort asc', :label => 'author'
    #config.add_sort_field 'title_sort asc, pub_date_sort desc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end
end
