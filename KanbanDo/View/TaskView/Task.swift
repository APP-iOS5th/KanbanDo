//
//  Item.swift
//  taskCreationView
//
//  Created by 김혜림 on 4/30/24.
//

import SwiftData
import SwiftUI

enum projectStatus: Comparable, Codable {
    case workDo
    case doing
    case done
}

//실습 내용 중 ColorMemo 참고해 작성 중
@Model
class ProjectTask {
    
    
    
    var id = UUID()
    //    var colorHex: String
    
    var title: String // 할 일 이름
    
    //description이라는 이름 쓸 수가 없다고 에러가 떠러 얘만 좀 바꿨습니다!
    var taskDescription: String // 구체적인 할 일 내용
    var closingDate: Date // 마감일
    var manager: String // 담당자. 데이터 타입을 뭘로 받으면 좋을지 모르겠어서 일단 String으로
    var status: projectStatus
    
    @Transient
    var createdClosingDateString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            return dateFormatter.string(from: closingDate)
        }
    }
    
    
    //컬러값 반환
    //    @Transient
    //    var color: Color {
    //        return Color(hex: colorHex)
    //    }
    
    init(title: String, taskDescription: String, closingDate: Date, manager: String, status: projectStatus) {
        //self.colorHex = Task.hexStringFormColor(color: color)
        
        self.title = title
        self.taskDescription = taskDescription
        self.closingDate = closingDate
        self.manager = manager
        self.status = status
    }
    
    //안쓰는 듯
    //    static func hexStringFormColor(color: Color) -> String {
    //        let components = color.resolve(in: EnvironmentValues())
    //
    //        //rgb 변수 만들기
    //        let r: CGFloat = CGFloat(components.red)
    //        let g: CGFloat = CGFloat(components.green)
    //        let b: CGFloat = CGFloat(components.blue)
    //
    //        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    //        print(hexString)
    //        return hexString
    //    }
}
