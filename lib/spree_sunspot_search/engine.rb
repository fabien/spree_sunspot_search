module SpreeSunspotSearch
  class Engine < Rails::Engine
    isolate_namespace SpreeSunspotSearch
    engine_name "spree_sunspot_search"

    config.to_prepare do
      # loads application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    initializer "spree_sunspot_search.preferences", :after => "spree.environment" do |app|
      Spree::Config.searcher_class = Spree::Search::SpreeSunspot::Search
    end

    initializer "spree_sunspot_search.environment", :before => :load_config_initializers, :after => "spree.environment" do |app|
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/models/spree/app_configuration/*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      app.config.spree.add_class('sunspot_preferences')
      app.config.spree.sunspot_preferences = SpreeSunspotSearch::SunspotConfiguration.new

      SpreeSunspotSearch::Config = app.config.spree.sunspot_preferences
    end
  end
end

# module SpreeSunspotSearch
#   class Engine < Rails::Engine
#     engine_name 'spree_sunspot_search'
# 
#     config.autoload_paths += %W(#{config.root}/lib)
# 
#     initializer "spree.sunspot_search.preferences", :after => "spree.environment" do |app|
#       Spree::Config.searcher_class = Spree::Search::SpreeSunspot::Search
#       Spree::SunspotSearch::Config = Spree::SunspotSearchConfiguration.new
#     end
# 
#     def self.activate
#       Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
#         Rails.configuration.cache_classes ? require(c) : load(c)
#       end
# 
#       # this allows us to develop the search class without restarting the app on each change
#       # I think in dev mode the engine's to_prepare block is called on each request
# 
#       if Rails.env.development?
#         Spree::Config.searcher_class = Spree::Search::SpreeSunspot::Search
#       end
#     end
# 
#     config.to_prepare &method(:activate).to_proc
#   end
# end