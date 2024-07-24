//
//  SocialMediaApp.swift
//  SocialMedia
//
//  Created by user on 7/16/24.
//

import SwiftUI
import FirebaseCore

@main
struct SocialMediaApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Login()
        }
    }
}
