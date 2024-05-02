//
//  CreateProjectView.swift
//  KanbanDo
//
//  Created by 이인호 on 4/30/24.
//

import SwiftUI

/**
    프로젝트 생성 화면
 */
struct CreateProjectView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var calendarId: Int = 0
    @State private var participants: [User] = []
    @State private var isNewNotePresented = false
    
    @Environment(\.dismiss) var dismiss
    
    var projectViewModel: ProjectViewModel?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("프로젝트 이름") {
                    TextField("", text: $title)
                }
                Section("프로젝트 설명") {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                Section("기간") {
                    // 캘린더에서 날짜 선택시 자동으로 접히게 .id, .onChange 사용
                    DatePicker("시작일", selection: $startDate, displayedComponents: [.date])
                        .id(calendarId)
                        .onChange(of: startDate) { oldValue, newValue in
                            calendarId += 1
                        }
                    
                    DatePicker("마감일", selection: $endDate, displayedComponents: [.date])
                        .id(calendarId)
                        .onChange(of: endDate) { oldValue, newValue in
                            calendarId += 1
                        }
                }
                Section("팀원") {
                    Button {
                        isNewNotePresented.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus")
                                .font(.headline)
                            Spacer()
                        }
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
                                Text(user.email)
                            }
                        }
                    }
                }
            }
            .navigationTitle("새 프로젝트")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        projectViewModel?.addProject(title: title, description: description,
                                                     startDate: startDate, endDate: endDate, participants: participants)
                        dismiss()
                    } label: {
                        Text("저장")
                            .font(.headline)
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

#Preview {
    CreateProjectView()
}
