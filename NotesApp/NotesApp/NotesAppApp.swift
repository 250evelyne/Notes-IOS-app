//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by mac on 2025-12-04.
//

import SwiftUI
import FirebaseCore

@main
struct NotesAppApp: App {
    
    // Initialize Firebase when app starts
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
