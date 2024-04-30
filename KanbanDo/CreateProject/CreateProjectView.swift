//
//  CreateProjectView.swift
//  KanbanDo
//
//  Created by 이인호 on 4/30/24.
//

import SwiftUI

struct CreateProjectView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var calendarId: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var projectService: ProjectService?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("프로젝트 이름") {
                    TextField("프로젝트 이름", text: $title)
                }
                Section("프로젝트 설명") {
                    TextField("프로젝트 설명", text: $description)
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
                Section("인원") {
                    
                }
            }
            .navigationTitle("새 프로젝트")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        projectService?.addProject(title: title, description: description,
                                                   startDate: startDate, endDate: endDate, participants: ["A"])
                        dismiss()
                    } label: {
                        Text("저장")
                            .font(.headline)
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
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
