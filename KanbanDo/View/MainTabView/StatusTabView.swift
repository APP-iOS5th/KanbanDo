

import SwiftUI

struct StatusTabView: View {
    // 샘플 데이터
    let workList: [ProjectTask]
    
    // 필터링 데이터 바인딩
    @Binding var selected: MainTabView.Tab
    
    @State var project: Project
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // 할일 시에만 추가하기 버튼 생성
                    if selected == .workDo {
                        NavigationLink(destination: TaskAddView(project: project)){
                            VStack(spacing:20) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.black)
                                Text("추가하기")
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                                
                            }
                            .padding(.vertical,5)
                            .frame(minHeight: 120)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                        )
                    }
                    if workList.count == 0 && workList.isEmpty {
                        Spacer()
                        VStack {
                            Text("리스트가 존재하지 않습니다.")
                                .font(.callout)
                        }
                        Spacer()
                        
                    } else {
                        // Task 목록
                        ForEach(workList, id: \.self) { work in
                            NavigationLink(destination: DetailPageView(tasks: work)) {
                                VStack(alignment: .leading) {
                                    Text(work.title)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 10)
                                    
                                    
                                    Text(work.description)
                                        .padding(.bottom, 40)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(2)
                                        .lineSpacing(2)
                                        .multilineTextAlignment(.leading)
                                    
                                    
                                    
                                    HStack {
                                        Text("마감일")
                                        Text("|")
                                        Text(work.manager.username)
                                    }
                                    .font(.system(size: 14))
                                    .tint(Color.gray)
                                    
                                    Spacer()
                                        .frame(maxWidth: .infinity)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.3))
                                )
                                .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
                            }
                            .tint(.black)
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 22, trailing: 16))
        }
        
    }
}

//#Preview {
//    StatusTabView(workList: ProjectDo.sampleDo, selected: .constant(.workDo))
//}
