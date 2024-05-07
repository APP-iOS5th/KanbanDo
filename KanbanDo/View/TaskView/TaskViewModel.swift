//
//  TaskViewModel.swift
//  KanbanDo
//
//  Created by 이인호 on 5/2/24.
//

import Firebase
import FirebaseFirestore

@Observable
class TaskViewModel {
    
    enum TaskAddError: Error {
        case missingManager
        case addDocumentFailed
    }
    
    var tasks: [ProjectTask]
    private let dbCollection = Firestore.firestore().collection("tasks")
    
    init(tasks: [ProjectTask] = []) {
        self.tasks = tasks
    }
    
    // 새 Task 추가
    func addTask(title: String, description: String, closingDate: Date, manager: User?, status: TaskStatus, projectID: String, completion: @escaping (Result<Void, TaskAddError>) -> Void)  {
        // 담당자를 선택하지 않은 경우
        guard let selectedManager = manager else {
            completion(.failure(.missingManager))
            return
        }
        
        let task = ProjectTask(id: UUID().uuidString, title: title, description: description,
                               closingDate: closingDate, manager: selectedManager, status: status, projectID: projectID, timeStamp: Date())
        
        _ = try? dbCollection.addDocument(from: task) { error in
            if error != nil {
                completion(.failure(.addDocumentFailed))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // get snapshot
    func fetchTasks(project: Project) {
        dbCollection.whereField("projectID", isEqualTo: project.id).getDocuments { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot: \(error!)")
                return
            }
            updateTasks(snapshot: snapshot)
        }
    }
    
    //수정 기능
    func editTask(task: ProjectTask, status: TaskStatus) {
        let docRef = dbCollection.whereField("id", isEqualTo: task.id)
        
        docRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.updateData([
                        "status": status.rawValue
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
    }
    
    private func updateTasks(snapshot: QuerySnapshot) {
        let tasks: [ProjectTask] = snapshot.documents.compactMap { document in
            try? document.data(as: ProjectTask.self)
        }
        
        // 생성일 순으로 정렬
        self.tasks = tasks.sorted {
            $0.timeStamp > $1.timeStamp
        }
    }
}
