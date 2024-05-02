//
//  taskCreationViewApp.swift
//  taskCreationView
//
//  Created by 김혜림 on 4/30/24.
//

import SwiftUI
import SwiftData

@main
struct ColorMemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Task.self)
        }
    }
}
