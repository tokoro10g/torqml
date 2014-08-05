#!/usr/bin/ruby -Ku
# -*- coding: utf-8 -*-

require 'qml'
class MazeWallGenerator_
  include QML::Access
  register_to_qml under: "TorQML.Plugins.MazeWallGenerator", version: "0.1" # QML: MazeWallGenerator

  property(:source) { "" }

  def prepare_data
    file = File.open(self.source, 'r')
    mode = file.readline.to_i
    @w = file.readline.to_i
    @h = file.readline.to_i
    gx = 7
    gy = 7

    if mode != 0
      gx = file.readline.to_i
      gy = file.readline.to_i
    end

    @horizwall = Array.new(@h) { Array.new(@w - 1) }
    @vertwall = Array.new(@h) { Array.new(@w - 1) }

    y = @h - 1
    x = 0
    file.readlines.each do |line|
      line.split(" ").each do |char|
        if x >= @w then next end
        c = 0
        if char.ord >= '0'.ord && char.ord <= '9'.ord
          c = char.ord - '0'.ord
        elsif char.ord >= 'a'.ord && char.ord <= 'f'.ord
          c = char.ord - 'a'.ord + 10
        end
        if (x != @w - 1 && (c & 0x2) == 0x2) then @vertwall[y][x] = 1 else @vertwall[y][x] = 0 end
        if (y != 0 && (c & 0x4) == 0x4) then @horizwall[y][x] = 1 else @horizwall[y][x] = 0 end
        x = x + 1
      end
      x = 0
      y = y - 1
    end
  end

  def width
    return @w
  end

  def height
    return @h
  end

  def horiz_wall?(x, y)
    return @horizwall[y][x]
  end

  def vert_wall?(x, y)
    return @vertwall[y][x]
  end

  alias_method :has_horiz_wall, :horiz_wall?
  alias_method :has_vert_wall, :vert_wall?

end

# vim:set ts=2 sw=2 et:
