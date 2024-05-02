//
//  DetailPageView.swift
//  KanbanDo
//
//  Created by 황승혜 on 5/1/24.
//


import SwiftUI

struct DetailPageView: View {
    @StateObject private var tasks: TaskForDetail
    
    init(taskName: String, taskDetails: String, workStatus: ProjectDo.projectStatus, personCharge: String, deadline: Date) {
            let task = TaskForDetail(taskName: taskName, taskDetails: taskDetails, workStatus: workStatus, personCharge: personCharge, deadline: deadline)
            _tasks = StateObject(wrappedValue: task)
        }
    
    var body: some View {
        
        VStack {
            List {
                VStack {
                    Text(tasks.taskName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    //TextField("설명을 입력하세요.", text: $tasks.taskDetails, axis: .vertical)
                    Text(tasks.taskDetails)
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
                        Text(tasks.personCharge)
                            .padding(.vertical)
                            .frame(alignment: .trailing)
                    
                }
                HStack {
                    Text("마감일")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(tasks.deadlineString)
                        .padding(.vertical)
                        .frame(alignment: .trailing)
                }
                
                HStack {
                    Text("상태")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    VStack {
                        Picker("", selection: $tasks.workStatus) {
                            Text("할 일").tag(ProjectDo.projectStatus.workDo)
                            Text("진행 중").tag(ProjectDo.projectStatus.doing)
                            Text("완료").tag(ProjectDo.projectStatus.done)
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
        DetailPageView(taskName: "새로운 태스크", taskDetails: "새로운 태스크 설명", workStatus: .doing, personCharge: "이름", deadline: Date())
    }
}
