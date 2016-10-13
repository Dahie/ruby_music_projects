require 'midilib/sequence'

# Get all measures, so events can be mapped to measures:

def note_plotter
  seq = MIDI::Sequence.new
  # Asks the user for midi track to read in..
  title = gets.chomp!
  File.open("#{title}", 'rb') { |file| seq.read(file) }
  measures = seq.get_measures
  count = 0
  seq.each { |track|
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

note_plotter
