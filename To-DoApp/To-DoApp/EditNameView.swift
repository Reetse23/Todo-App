//
//  EditNameView.swift
//  ToDoApp
//
//  Created by Thabiso Gaereetse on 2023/03/14.
//

import Foundation
import SwiftUI

struct EditNameView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var newUserName: String
    @Environment(\.presentationMode) var presentationMode

    private func saveUser() {
        do {
            let user = User(context: viewContext)
            user.newUserName = newUserName
            user.dateCreated = Date()
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }

    var body: some View {
        VStack {
            TextField("Type your name..", text: $newUserName)
                .padding()
                .textFieldStyle(.roundedBorder)

            Button(action: {
                saveUser()
            }, label: {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(40)
            })
            .padding()

        }
        .padding()
        .navigationBarTitle("Edit Name")
    }
}

