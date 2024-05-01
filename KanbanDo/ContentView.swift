//
//  ContentView.swift
//  KanbanDo
//
//  Created by 황승혜 on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("상세 보기") {
                DetailPageView()
            }
        }
    }
}

#Preview {
    ContentView()
}
