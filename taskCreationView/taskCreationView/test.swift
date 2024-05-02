//
//  test.swift
//  taskCreationView
//
//  Created by 김혜림 on 5/2/24.
//

import SwiftUI

struct test: View {
    @State private var wakeUp = Date()
    @State private var birthDate = Date()
    @State var taskDeadline = Date()
    
    //3.
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
//       //1.
//        DatePicker("날짜를 선택하세요", selection: $wakeUp)
//            //date피커스타일 에 .lablesHidden()을 사용하면 피커에 텍스트가 안보이게됨
//            .datePickerStyle(WheelDatePickerStyle()).labelsHidden()
//        //2.
        Form {
            DatePicker("Please enter a date", selection: $wakeUp)
            
        }
//        //3.
//        VStack {
//            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
//                Text("날짜를 선택하세요")
//            }
//            
//            Text("Date is \(birthDate, formatter: dateFormatter)")
//        }
//        .padding()
        
//        //4.
//        DatePicker("Please enter a date", selection: $wakeUp,
//                   displayedComponents: .hourAndMinute)
//            .datePickerStyle(WheelDatePickerStyle())
//            .labelsHidden()
//        
//        //5.
//        VStack {
//            Text("당신의 생일을 선택해주세요")
//                .font(.largeTitle)
//            DatePicker("당신의 생일을 선택해주세요", selection: $wakeUp)
//                .datePickerStyle(GraphicalDatePickerStyle())
//                //달력과 텍스트의 위치를 지정하는 프레임
//                .frame(maxHeight: 400)
//        }
        
        VStack {
        
            Form {
                DatePicker("test", selection: $taskDeadline, in: Date()..., displayedComponents: .date)
            }
        }
        
    }

    
}

#Preview {
    test()
}
