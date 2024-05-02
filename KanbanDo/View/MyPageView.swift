//
//  MyPageView.swift
//  KanbanDo
//
//  Created by mac on 5/1/24.
//

import SwiftUI

struct MyPageView: View {
    
    // MyPage Sheet Trigger
    @Binding var showMyPageSheet: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 140)
                .foregroundStyle(.gray)
                .padding(.vertical)
            
            Text("김성국")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("tjdrnr2969@gmail.com")
                .tint(.black)
            
            VStack {
                Button {
                    print("로그아웃")
                    showMyPageSheet = false
                } label: {
                    Text("SignOut")
                }
                .padding(EdgeInsets(top: 5, leading: 14, bottom: 5, trailing: 14))
                .foregroundStyle(.black)
                .border(.black)
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    MyPageView(showMyPageSheet: .constant(true))
}
