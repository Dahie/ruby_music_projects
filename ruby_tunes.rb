# ruby_tunes
# built on the shoulders of giants ( ruby_music_projects, practical_ruby_projects,
# midiator,
require_relative 'music'

class TunesConfig
  attr_accessor :channel

  def initialize(channel)
    @channel = channel
  end
end

class TunePlayer
  attr_accessor :channel

  def initialize(channel)
    @channel = channel
  end

  def play(note, len = 0.5)
    if(note.class == Array) then
      note.each { |n|
        if(n.class == Array) then
          n.each { |chord_note|
            MainMidi.note_on(@channel,chord_note,100)
          }
          sleep(len)
          n.each { |chord_note|
            MainMidi.note_off(@channel,chord_note,0)

          }
        else
          MainMidi.note_on(@channel,n,100)
          sleep(len)
          MainMidi.note_off(@channel,n,0)
        end
      }
      return
    end
    MainMidi.note_on(@channel,note,100)
    sleep(len)
    MainMidi.note_off(@channel,note,0)
  end

  def instrument(inst)
    MainMidi.program_change(@channel, inst)
  end

end

MainMidi = LiveMIDI.new
configs = TunesConfig.new 1

def play(note, len = 0.5)
  if(note.class == Array) then
    note.each { |n|
      if(n.class == Array) then
        n.each { |chord_note|
          MainMidi.note_on(configs.channel,chord_note,100)
        }
        sleep(len)
        n.each { |chord_note|
          MainMidi.note_off(configs.channel,chord_note,0)

        }
      else
        MainMidi.note_on(configs.channel,n,100)
        sleep(len)
        MainMidi.note_off(configs.channel,n,0)
      end
    }
    return
  end
  MainMidi.note_on(configs.channel,note,100)
  sleep(len)
  MainMidi.note_off(configs.channel,note,0)
end

def instrument(inst)
  MainMidi.program_change(configs.channel, inst)
end

