//
//  BlueView.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

struct GreenView: View {
    @State var showModal = true
    var body: some View {
        VStack {
            ShowAllView(isShown: $showModal, currentPriority: .low)
        }
        .background(Color.green)
    }
}

struct GreenView_Previews: PreviewProvider {
    static var previews: some View {
        GreenView()
    }
}
