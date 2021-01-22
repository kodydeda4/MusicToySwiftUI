//
//  PianoView.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/22/21.
//

import SwiftUI

struct PianoView: View {
    //let model = SoundModel(midiSoundFont: .emuaps_8mb)
    let piano = PianoSound(midiSoundFont: .emuaps_8mb)

    var body: some View {
        Button("press me") {
//            model.called(keyInfo: KeyInfo(color: .black, type: .center, n: 1, isPressed: true))
            piano.play(keyInfo: KeyInfo(color: .black, type: .center, n: 1, isPressed: true))
        }
    }
}


struct PianoView_Previews: PreviewProvider {
    static var previews: some View {
        PianoView()
    }
}
