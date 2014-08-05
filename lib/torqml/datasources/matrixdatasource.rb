#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-

require 'qml'
require_relative './datasource'

module TorQML
  module DataSources
    # Base class of matrix type data sources.
    class MatrixDataSource_rb < DataSource_rb
      # do not call register_to_qml here

      # Returns the current frame value at column index.
      #
      # @param [Integer] index index
      # @return [Float] the current frame value at column index
      def value_at(index)
        if @data.nil?
          raise "data not initialized"
          0
        else
          @data[currentFrame.to_i - 1][index.to_i]
        end
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
