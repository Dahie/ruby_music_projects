# The Ruby Music Project

This is a set of different ruby music projects that all can use the same basic  structure but use different approaches to creating simple midi music files and for playing Live Coding music in Ruby..

Most of the projects are based on and use the ruby midilib gem created by Jim Menard and the Livemidi is a modifed version based on the work by Topher Cyll.

## Installation

Clone this git repository and install all necessary dependencies:

    bundle install

For running

## Usage

### Automatic composing

    ruby demo_2.rb

Generates and plays a random live composition

    ruby live_movements.rb

Generates and plays random notes

    ruby advanced_live_settings.rb

Composes a live random multi track

### Analysis

    ruby read_midi.rb

Loads and parses a MIDI, and prints the notes by time index.


### Generate midi files

added parsesong.rb use like:

    ruby parsesong.rb <bpm> "<songdescription>" <filename>

Mary had a little lamb:

    ruby parsesong.rb 250 "e.d.c.d.e.e.e.d.d.d.e.g.g.e.d.c.d.e.e.e.e.d.d.e.d.ccc" mary.midi

    ruby random_song_generation.rb

Generates and saves a random MIDI file.

    ruby multi_channel_chord_progressions_setup.rb

Provides options to generate multiple generated MIDI files.

## Credits

Started & Created by Gabriel D
Email contact / Gtalk: Garrod gabrielg1976@gmail.com

Contributors include:

* Brian Browning
* Daniel Senff

