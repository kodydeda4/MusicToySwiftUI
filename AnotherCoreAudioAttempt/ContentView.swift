//
//  ContentView.swift
//  AnotherCoreAudioAttempt
//
//  Created by Kody Deda on 1/22/21.
//

import SwiftUI
import MusicTheory
import ComposableArchitecture

//struct MyScale: Equatable {
//    let scale: Scale
//    let octave: Int
//
//    var description: String {
//        scale.description
//            .filter { !($0 == ",") }
//    }
//
//    var midiValues: [Int] {
//        let values = scale.pitches(octave: octave).map(\.rawValue)
//        return Array(values + [values.first! + 12])
//    }
//}


//MARK:- Root

struct Root {
    struct State {
        // state
        var scale: Scale { .init(type: scaleType, key: key)}
        var midiValues: [Int] {
            let values = scale.pitches(octave: octave).map(\.rawValue)
            return Array(values + [values.first! + 12])
        }
        
        var octave: Int = 4
        var key: Key = "C"
        var scaleType: ScaleType = .major
        var soundFont: MidiSoundFont = .piano
        var piano = SoundClient(.piano)
    }
    
    enum Action: Equatable {
        // action
        case changeOctave(Int)
        case changeKey(Key)
        case changeScaleType(ScaleType)
        case changeSoundFont(MidiSoundFont)
    }
    
    struct Environment {
        // environment
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        // pullbacks
        
        Reducer { state, action, environment in
            // mutations
            switch action {
            
            case let .changeOctave(octave):
                state.octave = octave
                return .none
            case let .changeKey(key):
                state.key = key
                return .none
            case let .changeScaleType(scaleType):
                state.scaleType = scaleType
                return .none
                
            case let .changeSoundFont(soundFont):
                state.soundFont = soundFont
                return .none
            }
        }
    )
}

extension Root.State: Equatable {
    static func == (lhs: Root.State, rhs: Root.State) -> Bool {
        lhs.scale == rhs.scale
    }
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- RootView

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(viewStore.octave.description)
                HStack {
                    ForEach(viewStore.midiValues, id: \.self) { note in
                        Button(
                            action: { viewStore.piano.play(note) }
                        ) {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(
                                    [viewStore.midiValues.first, viewStore.midiValues.last]
                                        .contains(note) ? Color.blue : Color.red
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
            .navigationTitle(viewStore.scale.description.filter { $0 != "," })
            .toolbar {
                ToolbarItem {
                    Picker("SoundFont", selection:
                            viewStore.binding(
                                get: \.soundFont,
                                send: Root.Action.changeSoundFont)
                    ) {
                        ForEach(MidiSoundFont.allCases, id: \.self) { soundFont in
                            Text(soundFont.rawValue)
                        }
                    }
                }
                ToolbarItem {
                    Picker("Octave", selection:
                            viewStore.binding(
                                get: \.octave,
                                send: Root.Action.changeOctave)
                    ) {
                        ForEach(0..<9) { octave in
                            Text(octave.description)
                        }
                    }
                }
                ToolbarItem {
                    Picker("Key", selection:
                            viewStore.binding(
                                get: \.key,
                                send: Root.Action.changeKey)
                    ) {
                        ForEach(Key.keysWithFlats, id: \.self) { key in
                            Text(key.description)
                        }
                    }
                }
                ToolbarItem {
                    Picker("ScaleType", selection:
                            viewStore.binding(
                                get: \.scaleType,
                                send: Root.Action.changeScaleType)
                    ) {
                        ForEach(ScaleType.all, id: \.self) { scaleType in
                            Text(scaleType.description)
                        }
                    }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Root.defaultStore)
    }
}
