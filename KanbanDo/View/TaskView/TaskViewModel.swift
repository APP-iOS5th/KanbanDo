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
    var tasks: [ProjectTask]
    private let dbCollection = Firestore.firestore().collection("tasks")
    
    init(tasks: [ProjectTask] = []) {
        self.tasks = tasks
    }
    
    func addTask(title: String, description: String, closingDate: Date, manager: User?, status: TaskStatus, projectID: String) {
        guard let selectedManager = manager else {
            // manager가 nil일 경우 처리할 코드 작성
            print("Error: 담당자 선택을 하지 않으셨습니다.")
            return
        }
        
        let task = ProjectTask(id: UUID().uuidString, title: title, description: description,
                               closingDate: closingDate, manager: selectedManager, status: status, projectID: projectID, timeStamp: Date())
        
        _ = try? dbCollection.addDocument(from: task)
    }
    
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
        self.tasks = tasks.sorted {
            $0.timeStamp > $1.timeStamp
        }
    }
}
