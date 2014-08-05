#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-

require 'qml'
require 'csv'
require_relative './matrixdatasource'

module TorQML
  module DataSources
    # Data source class to provide CSV data.
    class CSVDataSource_rb < MatrixDataSource_rb
      include QML::Access
      register_to_qml # QML: CSVDataSource_rb

      # @return [String] the file path
      property(:source) { "" }
      # @return [String] the separator character of the CSV file
      property(:separator) { "" }

      # Prepare data to provide.
      # The separator of CSV data can be set via `:separator` property.
      # If not set, the method tries to detect it automatically.
      def prepare_data
        if self.separator.empty?
          # detect the separator of data
          File.open(self.source, "r") do |file|
            row = file.readline
            if row.match(/,/)
              self.separator = ','
            elsif row.match(/\t/)
              self.separator = '\t'
            elsif row.match(/\s/)
              self.separator = ' '
            end
          end
        end
        @data = CSV.read(self.source, {:converters => :float, :col_sep => self.separator})
      end

    end
  end
end

# vim:set ts=2 sw=2 et:
