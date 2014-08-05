require 'qml'

module TorQML
  # TorQML module of plugins
  module Plugins
    # Version of Plugins module.
    VERSION="0.1"

    # Returns default path of plugin directory.
    #
    # @return [String] the default directory
    def default_path
      ENV['HOME'] + '/.torqml/plugins'
    end

    # Preloads ruby modules of plugins.
    #
    # @param [Pathname] dir path to the directory that contains plugins
    def preload(dir)
      Pathname.glob(dir + '*/plugin.rb').each do |path|
        # load ruby modules
        require(path.realpath.dirname + path.basename)
      end
    end

    # Loads QML/C++ plugins.
    #
    # @param [QML::Application] app QML application
    # @param [Pathname] dir path to the directory that contains plugins
    def load(app, dir)
      Pathname.glob(dir + '*/plugin.rb').each do |path|
        # add directories into import path of the application
        app.engine.add_import_path("#{path.realpath.dirname}/qml") if (path.realpath.dirname + 'qml').exist?
        app.engine.add_import_path("#{path.realpath.dirname}/ext") if (path.realpath.dirname + 'ext').exist?
      end
    end

    module_function :default_path
    module_function :preload
    module_function :load
  end
end

# vim:set ts=2 sw=2 et:
