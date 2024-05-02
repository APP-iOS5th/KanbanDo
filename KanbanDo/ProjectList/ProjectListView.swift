//
//  ProjectListView.swift
//  KanbanDo
//
//  Created by 이상민 on 5/2/24.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(spacing: 20){
                    //프로젝트 생성
                    NavigationLink {
                        // TODO: 디테일 뷰
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 120)
                            .foregroundStyle(.gray.opacity(0.3))
                            .overlay{
                                Image(systemName: "plus")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                }//: LazyVStack
            }//: SCROLLVIEW
            .navigationTitle("칸반도")
        }//: NAVIGATIONSTACK
        .padding(.horizontal)
    }
}


#Preview {
    ProjectListView()
}
