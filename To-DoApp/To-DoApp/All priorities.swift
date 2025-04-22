//
//  All priorities.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/03/07.
//

import SwiftUI

struct All_priorities: View {
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
                            ShowAllView(isShown: $showModal)
                        }
                    }
                }
            }
        }
        
    }
}

struct All_priorities_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
