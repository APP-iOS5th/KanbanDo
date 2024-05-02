//
//  ContentView.swift
//  taskCreationView
//
//  Created by 김혜림 on 4/30/24.
//

import SwiftUI
import SwiftData

//실습 내용 중 ColorMemo 참고해 작성 중

struct ContentView: View {
    @State var showSheet = false
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Task.text) var tasks: [Task]
    
    //마감일 출력 양식
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    //태스크 저장소
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                List (tasks) { task in
                    HStack {
                        //태스크 출력 양식
                        VStack(alignment: .leading) {
                            Text("\(task.title)")
                                .font(.title)
                            
                            Text("\(task.deadline, formatter: dateFormatter)")
                                .font(.caption)
                            
                            Text("\(task.personCharge)")
                                .font(.caption)
                        }
                        .padding()
                        .background(.gray)
                        .contextMenu {
                            //예정으로 이동
                            Button {
                                //todo: 예정으로 이동하는 코드
                            } label: {
                                Text("예정으로 변경")
                            }
                            
                            //진행으로 이동
                            Button {
                                //todo: 진행으로 이동하는 코드
                            } label: {
                                Text("진행으로 변경")
                            }
                            
                            //완료로 이동
                            Button {
                                //todo: 완료로 이동하는 코드
                            } label: {
                                Text("완료로 변경")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Project Name")
                
                NavigationLink {
                    taskAddView()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("할 일 추가")
                    }
                    .frame(width: geometry.size.width * 0.9, height: 100)
                    .background(.gray)
                    .cornerRadius(10.0)
                    .foregroundColor(.white)
                }
                
//                Button("할 일 추가", systemImage: "plus.square.fill") {
////                    showSheet = true
//                }
//                .frame(width: geometry.size.width * 0.9, height: 100)
//                .background(.gray)
//                .cornerRadius(10.0)
//                .foregroundColor(.white)
//                .sheet(isPresented: $showSheet) {
//                    taskAddView(showSheet: $showSheet)
//                }
            }
        }
    }
    
}

struct taskAddView: View {
    
    @Environment(\.modelContext) var modelContext
    
//    @Binding var showSheet: Bool
    @State var taskTitle: String = ""
    @State var taskText: String = ""
    @State private var taskDeadline = Date()
    @State var taskStatus: Color =  .gray
    @State var taskPersonCharge: String = ""
    
    let taskStatusGroup: [Color] = [.gray, .green, .blue]
    
    var body: some View {
        VStack {
            // 상태 선택창
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("상태")
                            .font(.title3)
                            .fontWeight(.bold)
                        HStack {
                            //todo: 상태 선택 버튼
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    VStack(alignment: .leading) {
                        Text("할 일")
                            .font(.title3)
                            .fontWeight(.bold)
                        TextField("할 일을 적어주세요", text: $taskTitle, axis: .vertical)
                            .frame(width: 320, height: 25)
                            .padding(16)
                            .border(Color.gray.opacity(0.4), width: 1)
                            .cornerRadius(3.0)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                                        
                    VStack(alignment: .leading) {
                        Text("세부 내용")
                            .font(.title3)
                            .fontWeight(.bold)
                        TextField("세부 내용을 적어주세요", text: $taskText, axis: .vertical)
                            .frame(width: 320, height: 100)
                            .padding(16)
                            .border(Color.gray.opacity(0.4), width: 1)
                            .cornerRadius(3.0)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    VStack(alignment: .leading) {
                        //todo: 마감일 선택
                        DatePicker("마감일", selection: $taskDeadline, in: Date()..., displayedComponents: .date)
                            .font(.title3)
                            .fontWeight(.bold)
                        //.datePickerStyle(GraphicalDatePickerStyle()).labelsHidden()
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    VStack(alignment: .leading) {
                        Text("담당자")
                            .font(.title3)
                            .fontWeight(.bold)
                        //todo: 프로젝트에 포함된 사람 등록하는 기능
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
                }
                
                //todo: 위치/모양 바꾸기
                NavigationLink {
                    ContentView()
                } label: {
                    HStack {
                        Image(systemName: "Checkmark")
                        Text("완료")
                    }
                }
            }
        
            Button("완료") {
                addTask(taskTitle, taskText, taskPersonCharge, color: taskStatus)
            }
            .disabled(taskTitle.isEmpty)
            .disabled(taskText.isEmpty)
            //.disabled(taskPersonCharge.isEmpty)
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .scrollIndicators(.hidden, axes: .vertical)
    }
    
    func addTask(_ title: String, _ text: String, _ personCharge: String, color: Color) {
        let task = Task(color: color, title: title, text: text, deadline: Date(), personCharge: personCharge)
        modelContext.insert(task)
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
