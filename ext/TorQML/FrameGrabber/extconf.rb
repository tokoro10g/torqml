require 'mkmf'
require 'pathname'

class TorQMLBuilder

  def find_deps
    @pkgconfig_bin = with_config('pkg-config') || ENV['PKGCONFIG'] || find_executable('pkg-config')
    @qt_path = with_config('qt-dir') ? Pathname(with_config('qt-dir')).realpath : nil
    @make_bin = ENV['MAKE'] || find_executable('make')
    @qmake_bin = @qt_path ? @qt_path + 'bin/qmake' : find_executable('qmake')
  end

  def sh(command)
    system(command)
    success = $?.exitstatus == 0
    puts "Command '#{command}' not found." if $?.exitstatus == 127
    puts "Command '#{command}' failed." unless success
    success
  end

  def makefile
    sh("#{@qmake_bin}")
  end

  def qmake
    sh("#{@make_bin} qmake")
  end

  def build
    sh("#{@make_bin}")
  end

  def build_all
    find_deps
    makefile &&
      qmake &&
      build
  end

end

builder = TorQMLBuilder.new
builder.build_all

# vim:set ts=2 sw=2 et:
