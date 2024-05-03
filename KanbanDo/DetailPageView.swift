//
//  DetailPageView.swift
//  KanbanDo
//
//  Created by 황승혜 on 5/1/24.
//

import SwiftUI
import SwiftData

struct DetailPageView: View {
    @StateObject private var tasks: ProjectTask
    // ProjectTask 타입으로 변경
    init(title: String, taskDescription: String, closingDate: Date, manager: String, status: taskStatus) {
            let task = ProjectTask(title: title, taskDescription: taskDescription, closingDate: closingDate, manager: manager, status: status)
            _tasks = StateObject(wrappedValue: task)
        }
    
    var body: some View {
        
        VStack {
            List {
                VStack {
                    Text(tasks.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    //TextField("설명을 입력하세요.", text: $tasks.taskDetails, axis: .vertical)
                    Text(tasks.taskDescription)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                
                }
                .padding(.bottom)
                
                HStack {
                    Text("담당자")
                        .font(.title3)
                        .fontWeight(.bold)
                    Spacer()
                    Text(tasks.manager)
                            .padding(.vertical)
                            .frame(alignment: .trailing)
                    
                }
                HStack {
                    Text("마감일")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(tasks.createdClosingDateString)
                        .padding(.vertical)
                        .frame(alignment: .trailing)
                }
                
                HStack {
                    Text("상태")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    VStack {
                        Picker("", selection: $tasks.status) {
                            Text("할 일").tag(TaskStatus.workDo)
                            Text("진행 중").tag(TaskStatus.doing)
                            Text("완료").tag(TaskStatus.done)
                        }
                    }
                }
            }
        }
        .navigationTitle("상세 페이지")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailPageView(title: "Test", taskDescription: "이 편지는 영국에서 시작됐고", closingDate: Date(), manager: "담당자", status: .done)
    }
}
