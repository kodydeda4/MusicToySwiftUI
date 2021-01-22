//
//  SoundClient.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/22/21.
//

import AVFoundation

struct SoundClient {
    let midiSoundFont: MidiSoundFont
    let audioEngine = AVAudioEngine()
    let unitSampler = AVAudioUnitSampler()
    var volume: Float = 0.5

    init(_ midiSoundFont: MidiSoundFont) {
        self.midiSoundFont = midiSoundFont
        
        // Setup AudioEngine
        audioEngine.mainMixerNode.volume = volume
        audioEngine.attach(unitSampler)
        audioEngine.connect(unitSampler, to: audioEngine.mainMixerNode, format: nil)
        
        // Load MidiSoundFont into unitSampler
        if let _ = try? audioEngine.start() {
            try? unitSampler.loadSoundBankInstrument(
                at: midiSoundFont.url, program: 0,
                bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
                bankLSB: UInt8(kAUSampler_DefaultBankLSB)
            )
        }
    }
}

extension SoundClient {
    func play(_ note: Int) {
        unitSampler.startNote(UInt8(note), withVelocity: 80, onChannel: 0)
    }
    
    func stop(_ note: Int) {
        unitSampler.stopNote(UInt8(note), onChannel: 0)
    }
}
