//
//  ProjectService.swift
//  KanbanDo
//
//  Created by 이인호 on 4/30/24.
//

import Firebase
import FirebaseFirestore

@Observable
class ProjectViewModel {
    var projects: [Project]
    private let dbCollection = Firestore.firestore().collection("projects")
//    private let listener: ListenerRegistration?
    
    init(projects: [Project] = []) {
        self.projects = projects
    }
    
    // 프로젝트 리스트 보여주는 곳에서 수정해서 사용하시면 됩니당
    func fetchProjects() {
        dbCollection.getDocuments { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot: \(error!)")
                return
            }
            updateProjects(snapshot: snapshot)
        }
    }
    
    // 새 프로젝트 추가
    func addProject(title: String, description: String, startDate: Date, endDate: Date, participants: [User]) {
        let project = Project(id: UUID().uuidString, title: title, description: description,
                              startDate: startDate, endDate: endDate, participants: participants)
        
        _ = try? dbCollection.addDocument(from: project)
    }
    
    // 프로젝트 리스트 보여주는 곳에서 수정해서 사용하시면 됩니당
    private func updateProjects(snapshot: QuerySnapshot) {
        let projects: [Project] = snapshot.documents.compactMap { document in
            try? document.data(as: Project.self)
        }
        self.projects = projects.sorted {
            $0.startDate > $1.startDate
        }
    }
}