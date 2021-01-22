//
//  SoundFont.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/22/21.
//

import Foundation
import AVFoundation

struct SoundClient {
    public let midiSoundFont: MidiSoundFont

    private let audioEngine = AVAudioEngine()
    private let unitSampler = AVAudioUnitSampler()
    private var whiteNotes = [UInt8]()
    private var blackNotes = [UInt8]()
    
    init(midiSoundFont: MidiSoundFont, volume: Float = 0.5) {
        self.midiSoundFont = midiSoundFont
        
        audioEngine.mainMixerNode.volume = volume
        audioEngine.attach(unitSampler)
        audioEngine.connect(unitSampler, to: audioEngine.mainMixerNode, format: nil)
        if let _ = try? audioEngine.start() {
            loadSoundFont()
        }
    }
    
    private func loadSoundFont() {
        try? unitSampler.loadSoundBankInstrument(
            at: midiSoundFont.id, program: 0,
            bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
            bankLSB: UInt8(kAUSampler_DefaultBankLSB)
        )
    }
    
    func play(_ note: Int) {
        unitSampler.startNote(UInt8(note), withVelocity: 80, onChannel: 0)
    }
    
    func stop(_ note: Int) {
        unitSampler.stopNote(UInt8(note), onChannel: 0)
    }
}
