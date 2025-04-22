//
//  OrangeView.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

struct OrangeView: View {
    @State var showModal = true
    var body: some View {
        VStack {
            ShowAllView(isShown: $showModal, currentPriority: .medium)
        }
        .background(Color.orange)
    }
}

struct OrangeView_Previews: PreviewProvider {
    static var previews: some View {
        OrangeView()
    }
}
