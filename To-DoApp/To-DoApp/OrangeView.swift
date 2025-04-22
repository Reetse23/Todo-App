//
//  OrangeView.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

struct OrangeView: View {
    @State var showModal = true
    @Binding var isShown: Bool
    var body: some View {
        VStack {
            VStack {
                if isShown{
                    Color.black
                        .opacity(0.01)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShown = false
                        }
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.ultraThinMaterial.opacity(0.98))
                            .frame(height: 280)
                            
                        VStack{
                            ShowAllView(isShown: $showModal, currentPriority: .medium)
                        }
                    }
                }
            }
        }
        
    }
}

struct OrangeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
