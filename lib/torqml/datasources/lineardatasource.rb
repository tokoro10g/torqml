#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-

require 'qml'
require_relative './datasource'

module TorQML
  module DataSources
    # Data source class to provide simple linear data.
    # This class is useful when testing some models without preparing time-series data files.
    class LinearDataSource_rb < DataSource_rb
      include QML::Access
      register_to_qml # QML: LinearDataSource_rb

      # @return [Integer] the size of data
      property(:dataSize) { 0 }
      # @return [Float] the value step against index
      property(:dataStep) { 0 }

      # Prepare data to provide.
      def prepare_data
        @data = Array.new(self.dataSize) do |i|
          i * self.dataStep
        end
      end

      # Returns the current frame value.
      # Return value is not dependent on index argument.
      #
      # @param [Integer] index index
      # @return [Float] the current frame value
      def value_at(index)
        @data[currentFrame.to_i - 1]
      end

      # Returns the number of rows.
      #
      # @return [Integer] the number of rows
      def rows
        @data.length
      end

    end
  end
end

# vim:set ts=2 sw=2 et:
