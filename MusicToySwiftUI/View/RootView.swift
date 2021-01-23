//
//  RootView.swift
//  MusicToySwiftUI
//
//  Created by Kody Deda on 1/22/21.
//

import SwiftUI
import ComposableArchitecture
import MusicTheory

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                ForEach(viewStore.midiValues, id: \.self) { note in
                    Button(action: { viewStore.send(.playNote(note)) }) {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor([
                                viewStore.midiValues.first,
                                 viewStore.midiValues.last].contains(note)
                                    ? Color.secondary
                                    : Color.primary
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
            .navigationTitle(viewStore.scale.description.filter { $0 != "," })
            .toolbar {
                ToolbarItem {
                    Picker("SoundFont", selection:
                            viewStore.binding(  
                                get: \.soundClient.soundFont,
                                send: Root.Action.changeSoundFont)
                    ) {
                        ForEach(SoundFont.allCases, id: \.self) { soundFont in
                            Text(soundFont.rawValue)
                        }
                    }
                }
                ToolbarItem {
                    Picker("Key", selection:
                            viewStore.binding(
                                get: \.scale.key,
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
                                get: \.scale.type,
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
