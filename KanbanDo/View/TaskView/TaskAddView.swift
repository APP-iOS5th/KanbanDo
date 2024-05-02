

import SwiftUI
import SwiftData

//실습 내용 중 ColorMemo 참고해 작성 중

struct TaskAddView: View {
    
    @Environment(\.modelContext) var modelContext
    
    //dlwjs
    @Environment(\.dismiss) var dismiss
    
    //    @Binding var showSheet: Bool
    @State var title: String = ""
    @State var description: String = ""
    @State var closingDate: Date = Date()
    @State var status: projectStatus =  .workDo
    @State var manager: String = ""
    
    //팀원 추가
    @State private var participants: [User] = []
    @State private var isNewNotePresented = false
    
    
    
    //let taskStatusGroup: [Color] = [.gray, .green, .blue]
    
    var body: some View {
        VStack {
            // 상태 선택창
            ScrollView {
                VStack(alignment: .leading) {
                    //                    VStack(alignment: .leading) {
                    //                        Text("상태")
                    //                            .font(.title3)
                    //                            .fontWeight(.bold)
                    //                        HStack {
                    //                            //todo: 상태 선택 버튼
                    //                        }
                    //                    }
                    //                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    VStack(alignment: .leading) {
                        Text("할 일")
                            .font(.title3)
                            .fontWeight(.bold)
                        TextField("할 일을 적어주세요", text: $title, axis: .vertical)
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
                        TextField("세부 내용을 적어주세요", text: $description, axis: .vertical)
                            .frame(width: 320, height: 100)
                            .padding(16)
                            .border(Color.gray.opacity(0.4), width: 1)
                            .cornerRadius(3.0)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    VStack(alignment: .leading) {
                        //todo: 마감일 선택
                        DatePicker("마감일", selection: $closingDate, in: Date()..., displayedComponents: .date)
                            .font(.title3)
                            .fontWeight(.bold)
                        //.datePickerStyle(GraphicalDatePickerStyle()).labelsHidden()
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    VStack(alignment: .leading) {
                        Text("담당자")
                            .font(.title3)
                            .fontWeight(.bold)
                        Button {
                            isNewNotePresented.toggle()
                        } label: {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                    .font(.headline)
                                Spacer()
                            }
                            .background(Color.gray)
                        }
                        .sheet(isPresented: $isNewNotePresented) {
                            SearchUserView(participants: $participants)
                        }
                        List {
                            ForEach(participants) { user in
                                HStack {
                                    AsyncImage(url: user.photoURL) { image in
                                        image
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 50, height: 50)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text(user.username)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                //todo: 위치/모양 바꾸기
                Button {
                    dismiss()
                    addTask(title, description, closingDate, manager)
                    
                } label: {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("추가하기")
                    }
                }
                .disabled(title.isEmpty)
                .disabled(description.isEmpty)
            }
            
            //            Button("태스크 추가") {
            //
            //            }
            //            .disabled(taskTitle.isEmpty)
            //            .disabled(taskText.isEmpty)
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        .scrollIndicators(.hidden, axes: .vertical)
    }
    
    //    func addTask(_ title: String, _ text: String, _ personCharge: String, color: Color) {
    //        let task = Task(color: color, title: title, text: text, deadline: Date(), personCharge: personCharge)
    //        modelContext.insert(task)
    //    }
    
    func addTask(_ title: String, _ description: String, _ closingDate: Date, _ manager: String) {
        
        
        
        let task = ProjectTask(title: title, taskDescription: description, closingDate: Date(), manager: participants[0].username, status: .workDo)
        modelContext.insert(task)
    }
    
    //        var title: String
    //        var description: String
    //        var status: projectStatus
    //        var manager: String
    //        var closingDate: Date
    
}

#Preview {
    ContentView()
        .modelContainer(for: ProjectTask.self, inMemory: true)
}
