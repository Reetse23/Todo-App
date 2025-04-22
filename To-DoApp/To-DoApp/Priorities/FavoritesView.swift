//
//  Favorites.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/03/07.
//

import SwiftUI

struct FavoritesView: View {
    @State var showModal = true
    var body: some View {
        VStack {
            ShowAllView(isShown: $showModal, isFavorite)
        }
        .background(Color.red)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
