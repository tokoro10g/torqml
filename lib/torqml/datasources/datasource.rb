#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-

require 'qml'

module TorQML
  module DataSources
    # Base class of data sources.
    class DataSource_rb
      include QML::Access
      # do not call register_to_qml here because this class has no features

      # @return [Integer] the current frame number
      property(:currentFrame) { 1 }
      # Event signal for QML component.
      signal :dataTriggered, []

      # Emitts onDataTriggered event to the QML component.
      on_changed :currentFrame do
        dataTriggered.emit # QML: onDataTriggered
      end

      # Returns the current frame value at column index.
      # This is a dummy method.
      #
      # @param [Integer] index index
      # @return [Float] always returns index
      def value_at(index)
        index # dummy
      end

      # Returns the number of rows.
      # This is a dummy method.
      #
      # @return [Integer] always returns 0
      def rows
        0 # dummy
      end

    end
  end
end

# vim:set ts=2 sw=2 et:
