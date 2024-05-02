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

//임시 User Model
//struct User: Identifiable, Codable, Hashable{
//    var id: String
//    let url: URL? //이미지
//    let name: String //이름
//    let email: String //이메일
//}


//임시 프로젝트 Model
struct Project: Identifiable, Hashable, Codable{
    var id: String
    var title: String //제목
    var content: String //내용
    var startDate: Date //시작일
    var enddate: Date //종료일
    var personCharge: String //담당자
    var paricipants: Int //구성원
//    var user: User?
 }

 //임시 ViewModel
 class ProjectViewModel: ObservableObject{
     @Published var projects: [Project] = [Project(id: UUID().uuidString, title: "목록 만들기0", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2),
                                           Project(id: UUID().uuidString, title: "목록 만들기1", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2),
                                           Project(id: UUID().uuidString, title: "목록 만들기2", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2),
                                           Project(id: UUID().uuidString, title: "목록 만들기3", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2),
                                           Project(id: UUID().uuidString, title: "목록 만들기4", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2),
                                           Project(id: UUID().uuidString, title: "목록 만들기5", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2),
                                           Project(id: UUID().uuidString, title: "목록 만들기6", content: "배추 사오기, 잠자기", startDate: Date(), enddate: Date(), personCharge: "A", paricipants: 2)]
     //    @Published var projects = [Project]()
     //
     //    init(){
     //        Task { try await fetchProjects() }
     //    }
     //
     //    @MainActor
     //    func fetchProjects() async throws{
     //        self.projects = try await ProjectService.fetchProjectList()
     //    }

 }

//struct ProjectService{
//    private static let projectsCollection = Firestore.firestore().collection("projects")
//    static func fetchProjectList() async throws -> [Project]{
//        let snapshot = try await projectsCollection.getDocuments()
//        var projects = try snapshot.documents.compactMap({ try $0.data(as: Project.self)})
//
//        for index in 0..<projects.count{
//            let project = projects[index]
//        }
//        return projects
//    }
//
//    static func fetchUserProjects(email: String) async throws -> [Project]{
//        let snapshot = try await projectsCollection.whereField("email", isEqualTo: email).getDocument()
//        return try snapshot.documents.compactMap({ try $0.data(as: Project.self) })
//    }
//}

//임시 UserViewModel
//class UserViewModel{
//    private let user: User
//    @Published var projects = [Project]()
//
//    init(user: User) {
//        self.user = user
//
//        Task { try await fetchUserProjects()}
//    }
//
//    @MainActor
//    func fetchUserProjects() async throws{
//        self.projects = try await ProjectService.fetchUserProjects(email: user.email)
//
//        for index in 0..<projects.count{
//            projects[index].user = self.user
//        }
//    }
//}

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