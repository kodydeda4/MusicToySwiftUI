//
//  ContentView.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/22/21.
//

import SwiftUI
import MusicTheory

struct ContentView: View {
    
    @State var octave = 4
    @State var key: Key = "C"
    @State var scaleType: ScaleType = .major
    @State var selectedSoundfont: String = MidiSoundFont.piano.rawValue
    
    
    var body: some View {
        let piano = SoundClient(midiSoundFont: MidiSoundFont(rawValue: selectedSoundfont)!)

        let scale = Scale(type: scaleType, key: key)
        let scaleMidiValues = scale.pitches(octave: octave).map(\.rawValue)
        NavigationView {
            List {}
            VStack {
                Text(scale.description)
                
                HStack {
                    ForEach(scaleMidiValues, id: \.self) { note in
                        Button(Pitch(midiNote: note).description) {
                            piano.play(note)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Picker("SoundFont", selection: $selectedSoundfont) {
                    ForEach(MidiSoundFont.allCases) { soundFont in
                        Text(soundFont.rawValue)
                    }
                }
            }
            ToolbarItem {
                Picker("Tuning", selection: $octave) {
                    ForEach(0..<9) { octave in
                        Text(octave.description)
                    }
                }
            }
            ToolbarItem {
                Picker("Key", selection: $key) {
                    ForEach(Key.keysWithFlats, id: \.self) { key in
                        Text(key.description)
                    }
                }
            }
            ToolbarItem {
                Picker("ScaleType", selection: $scaleType) {
                    ForEach(ScaleType.all, id: \.self) { scaleType in
                        Text(scaleType.description)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



