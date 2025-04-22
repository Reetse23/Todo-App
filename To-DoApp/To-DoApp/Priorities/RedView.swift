//
//  NewPage.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

struct RedView: View {
    @State var showModal = true
    var body: some View {
        VStack {
            ShowAllView(isShown: $showModal, currentPriority: .high)
        }
        .background(Color.red)
    }
}

struct RedView_Previews: PreviewProvider {
    static var previews: some View {
        RedView()
    }
}
