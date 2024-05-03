//
//  Task.swift
//  KanbanDo
//
//  Created by 황승혜 on 5/1/24.
//

import Foundation

enum TaskStatus { // task 상태
    case workDo // 시작 전
    case doing // 진행 중
    case done // 완료
}

class TaskForDetail: ObservableObject { /* 클래스명 충돌로 수정 */
    //var taskID = UUID()
    var taskName: String  // 태스크 이름
    var taskDetails: String // task 설명 저장할 문자열
    var workStatus: TaskStatus // 상태 변경 가능
    var personCharge: String // 담당자
    var deadline: Date
    
    var deadlineString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd"
            
            return dateFormatter.string(from: deadline)
        }
    }
    
    init(taskName: String, taskDetails: String, workStatus: TaskStatus, personCharge: String, deadline: Date) {
        self.taskName = taskName
        self.taskDetails = taskDetails
        self.workStatus = workStatus
        self.personCharge = personCharge
        self.deadline = deadline
    }
}
