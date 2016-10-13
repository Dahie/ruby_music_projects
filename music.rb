#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>. 
require 'dl/import'
require 'unimidi'

module Enumerable
  def rest
    return [] if empty?
    self[1..-1]
  end
end

class LiveMIDI
  ON  = 0x90
  OFF = 0x80
  PC  = 0xC0

  attr_reader :interval, :output

  @@singleton = nil
  def self.use(bpm=120)
    return @@singleton = self.new(bpm) if @@singleton.nil?
    @@singleton.bpm = bpm
    return @@singleton
  end

  def initialize(bpm=120)
    self.bpm = bpm
    @output = ::UniMIDI::Output.gets
    @timer = Timer.get(@interval/10)
  end

  def bpm=(bpm)
    @interval = 60.0 / bpm
  end

  def play(channel, note, duration, velocity=100, time=nil)
    on_time = time || Time.now.to_f
    @timer.at(on_time) { note_on(channel, note, velocity) }
    
    off_time = on_time + duration
    @timer.at(off_time) { note_off(channel, note, velocity) }
  end

  def note_on(channel, note, velocity=64)
    output.puts(ON | channel, note, velocity)
  end

  def note_off(channel, note, velocity=64)
    output.puts(OFF | channel, note, velocity)
  end

  def program_change(channel, preset)
    output.puts(PC | channel, preset)
  end
end

class Timer
  def self.get(interval)
    @timers ||= {}
    return @timers[interval] if @timers[interval]
    return @timers[interval] = self.new(interval)
  end

  def initialize(resolution)
    @resolution = resolution

    Thread.new do
      while true
        dispatch
        sleep(@resolution)
      end
    end
  end
end

