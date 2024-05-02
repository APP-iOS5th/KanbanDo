//
//  TempView.swift
//  KanbanDo
//
//  Created by 이인호 on 5/1/24.
//

import SwiftUI

struct TempView: View {
    var authenticationViewModel = AuthenticationViewModel.shared
    var projectViewModel: ProjectViewModel = ProjectViewModel()
    
    @State private var isNewNotePresented = false
    
    var body: some View {
        NavigationStack {
            List(projectViewModel.projects) { project in
                NavigationLink(destination: MainTabView(project: project)) {
                    Text(project.title)
                }
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
            .fullScreenCover(isPresented: $isNewNotePresented) {
                CreateProjectView(projectViewModel: projectViewModel)
            }
            .task {
                projectViewModel.fetchProjects()
            }
            Button("Logout") {
                authenticationViewModel.logout()
            }
        }
        

    }
}

#Preview {
    TempView()
}
