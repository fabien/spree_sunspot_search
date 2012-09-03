module SpreeSunspotSearch
  class SunspotConfiguration < Spree::Preferences::Configuration
    preference :facet_display_limit, :integer, :default => -1
  end
end
