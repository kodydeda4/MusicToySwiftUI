//
//  MusicToySwiftUIApp.swift
//  MusicToySwiftUI
//
//  Created by Kody Deda on 1/22/21.
//

import SwiftUI

@main
struct MusicToySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Root.defaultStore)
        }
    }
}
