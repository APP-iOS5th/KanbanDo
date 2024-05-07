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
    
    enum ProjectAddError: Error {
        case missingParticipant
        case addDocumentFailed
    }
    
    var projects: [Project]
    private let dbCollection = Firestore.firestore().collection("projects")
    private var listener: ListenerRegistration?
    
    init(projects: [Project] = []) {
        self.projects = projects
        startRealtimeUpdates()
    }
    
    // get snapshot
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
    func addProject(title: String, description: String, startDate: Date, endDate: Date, participants: [User], completion: @escaping (Result<Void, ProjectAddError>) -> Void) {
        // 팀원을 한명도 추가하지 않은 경우
        if participants.isEmpty {
            completion(.failure(.missingParticipant))
            return
        }
        
        let project = Project(id: UUID().uuidString, title: title, description: description,
                              startDate: startDate, endDate: endDate, participants: participants)
        
        _ = try? dbCollection.addDocument(from: project) { error in
            if error != nil {
                completion(.failure(.addDocumentFailed))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // project snapshot에서 데이터를 가져옴
    private func updateProjects(snapshot: QuerySnapshot) {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let projects: [Project] = snapshot.documents.compactMap { document in
            try? document.data(as: Project.self)
        }.filter { project in
            // 내가 참여한 프로젝트만 가져오도록
            project.participants.contains { participant in
                participant.id == currentUser.uid
            }
        }
        
        // 시작일 기준 최근순으로 정렬
        self.projects = projects.sorted {
            $0.startDate > $1.startDate
        }
    }
    
    private func startRealtimeUpdates() {
        listener = dbCollection.addSnapshotListener { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("New comment: \(diff.document.data())")
                }
                if (diff.type == .modified) {
                    print("Modified comment: \(diff.document.data())")
                }
                if (diff.type == .removed) {
                    print("Removed comment: \(diff.document.data())")
                }
            }
            updateProjects(snapshot: snapshot)
        }
    }
}
