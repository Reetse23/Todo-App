//
//  SaveTask.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/28.
//

import SwiftUI

struct SaveTask: View {
    @Binding var isShown: Bool
    //@State private var showMenu = false
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .medium
    @Environment(\.managedObjectContext) private var viewContext
    @State private var modalShow = false
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    
    private func saveTask() {
        do {
            let task = Task(context: viewContext)
            task.title = title
            task.priority = selectedPriority.rawValue
            task.dateCreated = Date()
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func styleForPriority(_ value: String) -> Color {
        let priority = Priority(rawValue: value)
        
        switch priority {
        case .low:
            return Color.green
        case .medium:
            return Color.orange
        case .high:
            return Color.red
        default:
            return Color.black 
        }
    }
    var body: some View {
        
            VStack {
                if isShown{
                    Color.black
                        .opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShown = false
                        }
                    ZStack {
                        VStack {
                            Text("Add an Item")
                                .font(.headline)
                                .padding(.leading, -190)
                                
                            TextField("Enter title", text: $title)
                                .textFieldStyle(.roundedBorder)
                            Picker("Priority", selection: $selectedPriority) {
                                ForEach(Priority.allCases) { priority in
                                    Text(priority.title).tag(priority)
                                }
                            }.pickerStyle(.segmented)
                            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: {
                                Text("Date & Time")
                             }
                            )
                            Button("Save") {
                                saveTask()
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        }
                    }
                }
            }
    }
}

struct SaveTask_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
