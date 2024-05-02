//
//  DetailPageView.swift
//  KanbanDo
//
//  Created by 황승혜 on 5/1/24.
//


import SwiftUI

struct DetailPageView: View {
    @StateObject private var tasks = TaskList(taskName: "태스크 이름", taskDetails: """
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
""",
                                          workStatus: .doing, personCharge: ["박영식"], deadline: Date())
    
    var body: some View {
        
        VStack {
            List {
                VStack {
                    Text(tasks.taskName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    TextField("설명을 입력하세요.", text: $tasks.taskDetails, axis: .vertical)
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
                    ForEach(tasks.personCharge, id: \.self) { person in
                        Text(person)
                            .padding(.vertical)
                            .frame(alignment: .trailing)
                    }
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
                            Text("할 일").tag(Status.notStarted)
                            Text("진행 중").tag(Status.doing)
                            Text("완료").tag(Status.done)
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
        DetailPageView()
    }
}
