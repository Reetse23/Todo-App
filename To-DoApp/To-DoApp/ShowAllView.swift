//
//  NewView.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/03/01.
//

import SwiftUI

struct ShowAllView: View {
    @Binding var isShown: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    
    @State var filteredTasks: [Task] = []
    var currentPriority: Priority?
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                if isShown{
                    Color.black
                        .opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShown = false
                        }
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(Color.white)
                            .background(Color.white)
                            .overlay(
                                List {
                                    Text("No Items to show")
                                    ForEach(filteredTasks) { task in
                                        Text(task.title ?? "")
                                    }
                                    .onDelete(perform: deleteTask)
                                }
                            )
                        List {
                            ForEach(filteredTasks) { task in
                                HStack {
                                    Circle()
                                        .fill(styleForPriority(task.priority!))
                                        .frame(width: 15, height: 15)
                                    Spacer().frame(width: 20)
                                    Text(task.title ?? "")
                                    Spacer()
                                    ToDoToggel(task: task)
                                    Spacer()
                                    Image(systemName: task.isFavorite ? "heart.fill": "heart")
                                        .foregroundColor(.red)
                                        .onTapGesture {
                                            updateTask(task)
                                        }
                                    

                                }
                            }
                            .onDelete(perform: deleteTask)
                        }
                    }
                    .onAppear() {
                        applyFilter()
                    }
                    //.animation(.easeInOut)
                    .frame(height: 550)
                    
                }
                
            
            }
            
//            .onChange(of: allTasks) { newValue in
//                applyFilter()
//            }
        }}
    
    private func applyFilter() {
        let tasks = allTasks.map() { $0 }
        filteredTasks = tasks.filter {
            if let priority = currentPriority {
                return $0.priority == priority.rawValue
            }
            return true
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
    
    private func updateTask(_ task: Task) {
        
        task.isFavorite = !task.isFavorite
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)
            
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ToDoToggel: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        Toggle(isOn: $task.completed) {}
            .onChange(of: task.completed) { newValue in
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        
    }
}
struct ShowAllView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

