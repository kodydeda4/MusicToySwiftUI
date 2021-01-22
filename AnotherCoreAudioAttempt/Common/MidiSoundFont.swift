//
//  MidiSoundFont.swift
//  GuitarTunerSwiftUI
//
//  Created by Kody Deda on 1/20/21.
//

import Foundation

enum MidiSoundFont: String, Identifiable, CaseIterable {
    var id: URL { Bundle.main.url(forResource: rawValue, withExtension: "sf2")! }
    
    case piano = "Piano"
    case guitarElectric = "GuitarElectric"
    case guitarAcoustic = "GuitarAcoustic"
    case guitarNylon = "GuitarNylon"
}


