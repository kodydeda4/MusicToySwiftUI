//
//  SoundFont.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/20/21.
//

import Foundation

enum SoundFont: String, CaseIterable {
    var url: URL { Bundle.main.url(forResource: rawValue, withExtension: "sf2")! }
    
    case piano = "Piano"
    case guitarElectric = "Electric Guitar"
    case guitarAcoustic = "Acoustic Guitar"
    case guitarNylon = "Nylon Guitar"
}
