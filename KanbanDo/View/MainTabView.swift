
import SwiftUI




struct MainTabView: View {
    
    // 상태
    enum Tab {
        case workDo
        case doing
        case done
    }
    @State private var selected: Tab = .workDo
    
    // MyPage Sheet State
    @State var showMyPageSheet = false
    
    // Project Binding
    @State var project: Project
    
    // UserInfo
    var authenticationViewModel = AuthenticationViewModel.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selected) {
                    Group {
                        NavigationStack {
                            StatusTabView(workList: workListFilter(.workDo),selected: $selected)
                        }
                        .tag(Tab.workDo)
                        
                        NavigationStack {
                            StatusTabView(workList: workListFilter(.doing),selected: $selected)
                        }
                        .tag(Tab.doing)
                        
                        NavigationStack {
                            StatusTabView(workList: workListFilter(.done),selected: $selected)
                        }
                        .tag(Tab.done)
                    }
                }
                VStack {
                    Spacer()
                    TabComponent(selected: $selected)
                }
                .offset(y: 10)
            }
            .navigationTitle(project.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showMyPageSheet.toggle()
                        
                    } label: {
                        AsyncImage(url: authenticationViewModel.photoURL) { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 30, height: 30)
                        
                    }
                }
            }
            .sheet(isPresented: $showMyPageSheet) {
                MyPageView(showMyPageSheet: $showMyPageSheet)
            }
        }
    }
    
    // 상태에 따라 필터링된 배열 반환
    private func workListFilter(_ status: ProjectDo.projectStatus) -> [ProjectDo] {
        return ProjectDo.sampleDo.filter { $0.status == status }
    }
    
}




#Preview("MainTabView") {
    MainTabView(project:
                    Project(id: "test", title: "title", description: "description", startDate: Date(), endDate: Date(),  participants: [User(
                        id: "userid",
                        email: "useremail",
                        username: "userName",
                        photoURL: nil
                    )]
                           )
    )
}
