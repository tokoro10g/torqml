require 'qml'
require 'torqml/datasources'
require 'torqml/plugins'
require 'torqml/version'

# TorQML module.
module TorQML

  # Displays usage.
  def usage
    puts "torqml ver." + VERSION
    puts "usage: torqml <main.qml>"
  end

  # Main routine.
  def run
    if ARGV.length < 1 then usage; exit end

    torqml_root_dir = Pathname.new(__dir__).parent
    plugin_dir = Pathname.new(Plugins::default_path)
    qml_realpath = Pathname.new(ARGV[0]).realpath

    # preload ruby modules of plugins
    Plugins::preload(plugin_dir.dirname)
    Plugins::preload(qml_realpath.dirname + 'plugins')

    # change current directory to use relative paths in both ruby and QML
    Dir.chdir(qml_realpath.dirname) do
      QML.run do |app|
        # load QML/C++ components of plugins
        Plugins::load(app, plugin_dir.dirname)
        Plugins::load(app, qml_realpath.dirname + 'plugins')

        # add QML import paths
        app.engine.add_import_path("#{torqml_root_dir.realpath}/qml")
        app.engine.add_import_path("#{torqml_root_dir.realpath}/ext")

        app.load_path qml_realpath.basename
      end
    end
  end

  module_function :usage
  module_function :run
end

# vim:set ts=2 sw=2 et:
