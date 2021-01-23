//
//  RootState.swift
//  MusicToySwiftUI
//
//  Created by Kody Deda on 1/22/21.
//

import SwiftUI
import MusicTheory
import ComposableArchitecture

//MARK:- Root

struct Root {
    struct State {
        var scale = Scale(type: .major, key: "C")
        var soundClient = SoundClient(.piano)
            
        var midiValues: [Int] {
            let values = scale.pitches(octave: 4).map(\.rawValue)
            return Array(values + [values.first! + 12])
        }
    }
    
    enum Action: Equatable {
        case changeKey(Key)
        case playNote(Int)
        case changeScaleType(ScaleType)
        case changeSoundFont(SoundFont)
    }
    
    struct Environment {
        // environment
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        // pullbacks
        
        Reducer { state, action, environment in
            switch action {
                            
            case let .changeKey(key):
                state.scale.key = key
                return .none
                
            case let .changeScaleType(scaleType):
                state.scale.type = scaleType
                return .none
                
            case let .changeSoundFont(soundFont):
                state.soundClient = SoundClient(soundFont)
                return .none
                
            case let .playNote(note):
                state.soundClient.play(note)
                return .none
            }
        }
        .debug()
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

