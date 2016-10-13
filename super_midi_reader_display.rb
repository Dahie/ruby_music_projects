# Get all measures, so events can be mapped to measures:

require 'midilib'
require 'midilib/sequence'
require_relative 'rubymusicengine'
require_relative 'scales'

=begin
This application generates a simple random midi file and then outputs the notes generated and
at what time it did each note
=end


def song_creator_and_display
  seq = MIDI::Sequence.new
  s = [ ]
  100.times { |n| s << lydian_min[rand(lydian_min.size)] }
  s.to_midi("new_song1.mid")
# Then takes the new generated midi file and maps out the notes and time
  File.open("new_song1.mid", 'rb') { | file | seq.read(file) }
  measures = seq.get_measures
  count=0
  seq.each do |track|
    track.each do |event|
      if event.is_a? MIDI::NoteOn
        count += 1
        event.print_note_names = true
        # puts "the note #{count} was #{event.note_to_s}"
        puts "#{measures.to_mbt(event)} #{event.note_to_s}"
      end
    end
  end
end

song_creator_and_display
