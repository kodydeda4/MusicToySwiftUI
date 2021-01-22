//
//  PianoModel.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/22/21.
//

import Foundation

class SoundModel {
    let piano: PianoSound
    
    init(midiSoundFont: MidiSoundFont) {
        self.piano = PianoSound(midiSoundFont: midiSoundFont)
    }

    func called(keyInfo: KeyInfo) {
        Swift.print(keyInfo.description)
        if keyInfo.isPressed {
            piano.play(keyInfo: keyInfo)
        } else {
            piano.stop(keyInfo: keyInfo)
        }
    }
}

