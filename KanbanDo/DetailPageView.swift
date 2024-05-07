//
//  DetailPageView.swift
//  KanbanDo
//
//  Created by 황승혜 on 5/1/24.
//

import SwiftUI
import SwiftData


struct DetailPageView: View {
    @State var tasks: ProjectTask
    // ProjectTask 타입으로 변경
//    init(title: String, taskDescription: String, closingDate: Date, manager: String, status: TaskStatus) {
//            let task = ProjectTask(title: title, taskDescription: taskDescription, closingDate: closingDate, manager: manager, status: status)
//            _tasks = StateObject(wrappedValue: task)
//        }
    
    // Status 변경
    @State private var changeStatus: TaskStatus = .workDo
    var taskViewModel: TaskViewModel = TaskViewModel()
    
    @Environment(\.dismiss) var dismiss
    

    
    var body: some View {
        
        VStack {
            List {
                VStack {
                    Text(tasks.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    //TextField("설명을 입력하세요.", text: $tasks.taskDetails, axis: .vertical)
                    Text(tasks.description)
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
                    Text(tasks.manager.username)
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
                        Picker("", selection: $changeStatus) {
                            Text("할 일").tag(TaskStatus.workDo)
                            Text("진행 중").tag(TaskStatus.doing)
                            Text("완료").tag(TaskStatus.done)
                        }
                        .onAppear {
                            changeStatus = tasks.status
                        }
                    }
                }
                // 상태변경
                HStack(alignment: .center) {
                    Button {
                        taskViewModel.editTask(task: tasks, status: changeStatus)
                        dismiss()
                    } label: {
                        HStack(alignment: .center){
                            Spacer()
                            Image(systemName: "checkmark")
                            Text("변경하기")
                            Spacer()
                        }
                    }
                    .disabled(changeStatus == tasks.status)
                }
            }
        }
        .navigationTitle("상세 페이지")
        .navigationBarTitleDisplayMode(.inline)
        

        
       
    }
}

//#Preview {
//    NavigationStack {
//        DetailPageView(title: "Test", taskDescription: "이 편지는 영국에서 시작됐고", closingDate: Date(), manager: "담당자", status: .done)
//    }
//}
