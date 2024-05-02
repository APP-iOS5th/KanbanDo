//
//  ProjectListView.swift
//  KanbanDo
//
//  Created by 이상민 on 5/2/24.
//

import SwiftUI

struct ProjectListView: View {
    
    //MARK: - property
    @StateObject private var viewModel = ProjectViewModel()
    @State private var isPressedCreateBtn = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    //프로젝트 목록
                    ForEach(viewModel.projects){ project in
                        NavigationLink(value: project) {
                            ProjectListItem(project: project)
                        }
                    }//: LOOP

                    //프로젝트 생성
                    Button {
                        // TODO: 프로젝트 생성 뷰
                        isPressedCreateBtn.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .foregroundStyle(.white)
                            .shadow(color: .gray, radius: 4, x: 1, y: 1)
                            .opacity(0.3)
                            .overlay{
                                Image(systemName: "plus")
                                    .foregroundStyle(.black)
                            }
                    }
                    .padding(.vertical)
                }//: LazyVStack
                .padding(.horizontal)
                .foregroundStyle(.black)
                //디테일 뷰로 이동
                .navigationDestination(for: Project.self) { project in
                    DetailView(project: project)
                }
            }//: SCROLLVIEW
            .navigationTitle("칸반도")
            .navigationBarTitleDisplayMode(.inline)
        }//: NAVIGATIONSTACK
        .fullScreenCover(isPresented: $isPressedCreateBtn, content: {
            //프로젝트 생성 뷰
            CreateView()
        })
    }
}

//임시 프로젝트 Model
 struct Project: Identifiable, Hashable{
     let id = UUID()
     var title: String //제목
     var content: String //내용
     var startDate: Date //시작일
     var enddate: Date //종료일
     var paricipants: Int //구성원
 }

 //임시 ViewModel
 class ProjectViewModel: ObservableObject{
     @Published var projects: [Project] = [Project(title: "목록 만들기0", content: "목록 만들기0", startDate: Date(), enddate: Date(), paricipants: 2),
                                           Project(title: "목록 만들기1", content: "목록 만들기1", startDate: Date(), enddate: Date(), paricipants: 2),
                                           Project(title: "목록 만들기2", content: "목록 만들기2", startDate: Date(), enddate: Date(), paricipants: 2),
                                           Project(title: "목록 만들기3", content: "목록 만들기3", startDate: Date(), enddate: Date(), paricipants: 2),
                                           Project(title: "목록 만들기4", content: "목록 만들기4", startDate: Date(), enddate: Date(), paricipants: 2),
                                           Project(title: "목록 만들기5", content: "목록 만들기5", startDate: Date(), enddate: Date(), paricipants: 2),
                                           Project(title: "목록 만들기6", content: "목록 만들기6", startDate: Date(), enddate: Date(), paricipants: 2)]
 }

 struct DetailView: View{
     var project: Project

     var body: some View{
         Text("\(project.title)의 디테일 뷰 입니다.")
     }
 }

 struct CreateView: View {
     //MARK: - property
     @Environment(\.dismiss) private var dismiss

     var body: some View {
         VStack{
             Text("프로젝트 생성 뷰 입니다.")
             Button {
                 dismiss()
             } label: {
                 RoundedRectangle(cornerRadius: 10)
                     .stroke(.gray, lineWidth: 2)
                     .frame(width: 150, height: 50)
                     .overlay{
                         Text("닫기")
                     }
             }
         }
     }
 }
    
#Preview {
    ProjectListView()
}
