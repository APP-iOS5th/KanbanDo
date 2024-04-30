//
//  ContentView.swift
//  KanbanDo
//
//  Created by 황승혜 on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    var projectService: ProjectService = ProjectService()
    
    @State private var isNewNotePresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isNewNotePresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
            
            .sheet(isPresented: $isNewNotePresented) {
                CreateProjectView(projectService: projectService)
            }
        }
    }
}

#Preview {
    ContentView()
}
