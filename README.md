SpreeSunspotSearch
==================

Adds Solr search to Spree using [Sunspot](https://github.com/sunspot/sunspot).

This is compatible with Spree 1.1.x. Untested on 1.0, but will probably work without too much modification.


Install
=======

Add spree_sunspot_search to your Gemfile and run bundler.

`gem 'spree_sunspot_search', git: 'git://github.com/iloveitaly/spree_sunspot_search.git'`

add the following to the Gemfile if you are not using another solr install locally for testing and development. The rake tasks for starting and stop this for development are included automatically for your use.

	group :test, :development do
		gem 'sunspot_solr'
	end


Install the solr.yml file from Sunspot.

`rails g sunspot_rails:install`

Copy the initializer and add `solr_sort_by` to `all.js`:

`rails g spree_sunspot_search:install`

Running
=======

Start up Solr (bundled with Sunspot's install)

`rake sunspot:solr:run`

Build the index for the first time

`rake sunspot:reindex`

Stop the solr process:

`rake sunspot:solr:stop`

Customize the Facets Shown
--------------------------

Edit the [initializer](https://github.com/iloveitaly/spree_sunspot_search/blob/master/lib/generators/templates/spree_sunspot_search.rb) created by the installation script.
The initializer template should provide enough examples to get you started.

TODO
=====

* Add an automatic MAX value for price facets (e.g. Above <max_said_value>)
* Sorting by facet criteria and Solr analytics (Best result, Popular, etc.)
* Open the Sunspot DSL to utilise all the additional data and analytics available through Solr
* Get the Taxon browsing (e.g. Categories) to utilise the Solr data for speed boosts

Authors
=======
* @jbrien
* @iloveitaly

Copyright (c) 2011 John Brien Dilts, released under the New BSD License
