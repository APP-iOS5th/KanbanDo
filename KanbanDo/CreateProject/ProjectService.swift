//
//  ProjectService.swift
//  KanbanDo
//
//  Created by 이인호 on 4/30/24.
//

import Firebase
import FirebaseFirestore

@Observable
class ProjectService {
    var projects: [Project]
    private let dbCollection = Firestore.firestore().collection("projects")
//    private let listener: ListenerRegistration?
    
    init(projects: [Project] = []) {
        self.projects = projects
    }
    
    func addProject(title: String, description: String, startDate: Date, endDate: Date, participants: [String]) {
        let project = Project(id: UUID().uuidString, title: title, description: description,
                              startDate: startDate, endDate: endDate, participants: participants)
        
        _ = try? dbCollection.addDocument(from: project)
    }
}
