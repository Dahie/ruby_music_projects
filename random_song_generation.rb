require 'midilib'
require_relative 'rubymusicengine'
require_relative 'scales'

def random_basic_pattern
  1000.times {|n| s << rand(127)}
  s.to_midi("composition.mid")
end

def equation_song_1
  scale = []
  500.times { |n| s << Math.cos(rand(6)+3*Math.sqrt(5)) }
  puts scale
  scale.to_midi("composition4.mid")
end

def equation_song_2
end

def equation_song_3
end

def equation_song_5
end

def scale_song
  scale = []
  100.times { |n| scale << lydian_min[rand(lydian_min.size)] }
  scale.to_midi("scale_song1.mid")
end

# Calls to the methods
# random_basic_pattern
# equation_song_1
scale_song
