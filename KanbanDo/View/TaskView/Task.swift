//
//  Item.swift
//  taskCreationView
//
//  Created by 김혜림 on 4/30/24.
//

import SwiftData
import SwiftUI

//실습 내용 중 ColorMemo 참고해 작성 중
@Model
class ProjectTask {
    var id = UUID()
    var colorHex: String
    
    var title: String // 할 일 이름
    var text: String // 구체적인 할 일 내용
    var deadline: Date // 마감일
    var personCharge: String // 담당자. 데이터 타입을 뭘로 받으면 좋을지 모르겠어서 일단 String으로
   
    //컬러값 반환
    @Transient
    var color: Color {
        return Color(hex: colorHex)
    }
    
    init(color: Color, title: String, text: String, deadline: Date, personCharge: String) {
        self.colorHex = ProjectTask.hexStringFormColor(color: color)
        
        self.title = title
        self.text = text
        self.deadline = deadline
        self.personCharge = personCharge
    }
    
    static func hexStringFormColor(color: Color) -> String {
        let components = color.resolve(in: EnvironmentValues())
        
        //rgb 변수 만들기
        let r: CGFloat = CGFloat(components.red)
        let g: CGFloat = CGFloat(components.green)
        let b: CGFloat = CGFloat(components.blue)
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        print(hexString)
        return hexString
    }
}
