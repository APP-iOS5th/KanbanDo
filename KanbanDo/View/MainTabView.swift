
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
            .navigationTitle("Project Name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("마이페이지 클릭")
                    } label: {
                        VStack {
                            Button {
                                showMyPageSheet.toggle()
                            } label: {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 30))
                            }
                        }
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
    MainTabView()
}
