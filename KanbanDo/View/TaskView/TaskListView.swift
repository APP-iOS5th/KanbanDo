//
//  TaskListView.swift
//  KanbanDo
//
//  Created by 김소혜 on 5/2/24.
//

import SwiftUI
import SwiftData

//실습 내용 중 ColorMemo 참고해 작성 중
//안 쓰는 뷰

//struct TaskListView: View {
//    @State var showSheet = false
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Task.text) var tasks: [Task]
//    
//    //마감일 출력 양식
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        return formatter
//    }
//    
//    //태스크 저장소
//    var body: some View {
//        GeometryReader { geometry in
//            NavigationStack {
//                List (tasks) { task in
//                    HStack {
//                        //태스크 출력 양식
//                        VStack(alignment: .leading) {
//                            Text("\(task.title)")
//                                .font(.title)
//                            
//                            Text("\(task.deadline, formatter: dateFormatter)")
//                                .font(.caption)
//                            
//                            Text("\(task.personCharge)")
//                                .font(.caption)
//                        }
//                        .padding()
//                        .background(.gray)
//                        .contextMenu {
//                            //예정으로 이동
//                            Button {
//                                //todo: 예정으로 이동하는 코드
//                            } label: {
//                                Text("예정으로 변경")
//                            }
//                            
//                            //진행으로 이동
//                            Button {
//                                //todo: 진행으로 이동하는 코드
//                            } label: {
//                                Text("진행으로 변경")
//                            }
//                            
//                            //완료로 이동
//                            Button {
//                                //todo: 완료로 이동하는 코드
//                            } label: {
//                                Text("완료로 변경")
//                            }
//                        }
//                    }
//                }
//                .listStyle(.plain)
//                .navigationTitle("Project Name")
//                
//                NavigationLink {
//                    TaskAddView()
//                } label: {
//                    HStack {
//                        Image(systemName: "plus")
//                        Text("할 일 추가")
//                    }
//                    .frame(width: geometry.size.width * 0.9, height: 100)
//                    .background(.gray)
//                    .cornerRadius(10.0)
//                    .foregroundColor(.white)
//                }
//                
////                Button("할 일 추가", systemImage: "plus.square.fill") {
//////                    showSheet = true
////                }
////                .frame(width: geometry.size.width * 0.9, height: 100)
////                .background(.gray)
////                .cornerRadius(10.0)
////                .foregroundColor(.white)
////                .sheet(isPresented: $showSheet) {
////                    TaskAddView(showSheet: $showSheet)
////                }
//            }
//        }
//    }
//    
//}
