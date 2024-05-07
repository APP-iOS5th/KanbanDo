

import SwiftUI

struct TabComponent: View {
    
    // 필터링 데이터 바인딩
    @Binding var selected: MainTabView.Tab
    
    
    
    var body: some View {
        HStack {
            
            Spacer()
            
            Button {
                selected = .workDo
            } label: {
                VStack(alignment: .center) {
                    
                    if selected == .workDo {
                        Text("할일")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                    } else {
                        Image(systemName: "timer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                }
            }
            .padding(10)
            .frame(width: 69, height: 69)
            .foregroundStyle(selected == .workDo ? Color.white : Color.black.opacity(0.7))
            .background(selected == .workDo ? Color(white: 0.2745) : Color(white: 0.6745))
            .clipShape(Circle())
            
            Spacer()
            
            Button {
                selected = .doing
            } label: {
                VStack(alignment: .center) {
                    
                    if selected == .doing {
                        Text("진행중")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                    } else {
                        Image(systemName: "arrowshape.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                }
            }
            .padding(10)
            .frame(width: 69, height: 69)
            .foregroundStyle(selected == .doing ? Color.white : Color.black.opacity(0.7))
            .background(selected == .doing ? Color(white: 0.2745) : Color(white: 0.6745))
            .background(Color.black.opacity(0.2))
            .clipShape(Circle())
            
            Spacer()
            
            Button {
                selected = .done
            } label: {
                VStack(alignment: .center) {
                    
                    if selected == .done {
                        Text("완료")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                    } else {
                        Image(systemName: "d.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                }
            }
            .padding(10)
            .frame(width: 69, height: 69)
            .foregroundStyle(selected == .done ? Color.white : Color.black.opacity(0.7))
            .background(selected == .done ? Color(white: 0.2745) : Color(white: 0.6745))
            .background(Color.black.opacity(0.2))
            .clipShape(Circle())
            
            Spacer()
            
        }
        .frame(height: 70)
        .padding(.horizontal)
        .background(Color.white)
    }
}


#Preview {
    TabComponent( selected: .constant(.workDo))
}
