//
//  Item.swift
//  taskCreationView
//
//  Created by 김혜림 on 4/30/24.
//

import SwiftData
import SwiftUI

import Foundation

enum TaskStatus: String, Codable {
    case workDo
    case doing
    case done
}

// FireStore에 저장할 Task Model. Task라는 이름이 구글 인증과 겹쳐서 ProjectTask로 변경
struct ProjectTask: Identifiable, Codable, Hashable {
    
    var id: String
    var title: String // 할 일 이름
    var description: String // 구체적인 할 일 내용
    var closingDate: Date // 마감일
    var manager: User // 담당자
    var status: TaskStatus // 할 일 상태
    var projectID: String // 프로젝트에 속한 Task들만 필터링하기 위해 프로젝트 식별자 저장
    var timeStamp: Date // 날짜순 정렬을 위해 timestamp 저장
    
    @Transient
    var createdClosingDateString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.string(from: closingDate)
        }
    }
}

//@Model
//class ProjectTask : ObservableObject{
//    
//    
//    
//    var id = UUID()
//    //    var colorHex: String
//    
//    var title: String // 할 일 이름
//    
//    //description이라는 이름 쓸 수가 없다고 에러가 떠러 얘만 좀 바꿨습니다!
//    var taskDescription: String // 구체적인 할 일 내용
//    var closingDate: Date // 마감일
//    var manager: String // 담당자. 데이터 타입을 뭘로 받으면 좋을지 모르겠어서 일단 String으로
//    var status: taskStatus
//    
//    @Transient
//    var createdClosingDateString: String {
//        get {
//            let dateFormatter: DateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            
//            return dateFormatter.string(from: closingDate)
//        }
//    }
//    
//
//    
//    init(title: String, taskDescription: String, closingDate: Date, manager: String, status: taskStatus) {
//        //self.colorHex = Task.hexStringFormColor(color: color)
//        
//        self.title = title
//        self.taskDescription = taskDescription
//        self.closingDate = closingDate
//        self.manager = manager
//        self.status = status
//    }
//
//}
