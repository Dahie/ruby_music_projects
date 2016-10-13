require 'midilib'
require_relative 'main_midi_logic'
require_relative 'scales'

NOTE_MAPPING = {
  'c' => 0,
  'C' => 1,
  'd' => 2,
  'D' => 3,
  'e' => 4,
  'f' => 5,
  'F' => 6,
  'g' => 7,
  'G' => 8,
  'a' => 9,
  'A' => 10,
  'b' => 11,
}

def to_midi_note(note)
  NOTE_MAPPING[note]
end

duration = %w(quarter half whole) # 8th 16th 32nd 64th)
bpm = ARGV[0].to_i
song = MIDI::Sequence.new
melody = TimedTrack.new(0,song)
song.tracks << melody
melody.instrument = 29
melody.events << MIDI::Tempo.new(MIDI::Tempo.bpm_to_mpq(bpm)) # Controls tempo
melody.events << MIDI::MetaEvent.new(MIDI::META_SEQ_NAME, 'Alphacore') # title of track
notes = ARGV[1]
seq = notes.split('.')
seq.each do |note|
  melody.add_notes(to_midi_note(note[0,1]), 127, duration[note.length - 1].to_s)
end
open(ARGV[2], 'w') { |f| song.write(f) }
