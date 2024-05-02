//
//  Item.swift
//  taskCreationView
//
//  Created by 김혜림 on 4/30/24.
//

import SwiftData
import SwiftUI

//실습 내용 중 ColorMemo 참고해 작성 중

//상태 확장: 컬러로 상태 구분
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

@Model
class Task {
    var id = UUID()
    var colorHex: String
    
    var title: String // 할 일 이름
    var text: String // 구체적인 할 일 내용
    //var deadline: Date // 마감일
    var personCharge: String // 담당자. 데이터 타입을 뭘로 받으면 좋을지 모르겠어서 일단 String으로
   
    //컬러값 반환
    @Transient
    var color: Color {
        return Color(hex: colorHex)
    }
    
    init(color: Color, title: String, text: String, deadline: Date, personCharge: String) {
        self.colorHex = Task.hexStringFormColor(color: color)
        
        self.title = title
        self.text = text
       // self.deadline = deadline
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
