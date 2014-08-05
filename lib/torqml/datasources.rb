module TorQML
  # TorQML module of datasources.
  module DataSources
    # Version of DataSources.
    VERSION = "0.1"
  end
end

require_relative 'datasources/csvdatasource.rb'
require_relative 'datasources/lineardatasource.rb'

# vim:set ts=2 sw=2 et:
