//
//  CompletedItemView.swift
//  ToDoApp
//
//  Created by Thabiso Gaereetse on 2023/03/12.
//

import SwiftUI

struct CompletedItemView: View {
    @State private var isRenamingTask = false
    @State private var selectedTask: Task?
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Task.priority, ascending: false)])
    private var tasks: FetchedResults<Task>
    @State var filteredTasks: [Task] = []
    
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
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .ignoresSafeArea()
                .foregroundColor(Color.white)
                .background(Color.white)
                .overlay(
                    Image("Empty-cuate")
                        .resizable()
                )
                .overlay(
                    List {
                        Text("No completed Items to show")
                        Image("Empty-cuate")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.4)
                        ForEach(filteredTasks) { task in
                            Text(task.title ?? "")
                        }
                        .onDelete(perform: deleteTask)
                    }
                )
                .frame(width: 400)
                .cornerRadius(40)
            
            List {
                ForEach(tasks.filter { $0.completed }) { task in
                    HStack {
                        Circle()
                            .fill(styleForPriority(task.priority!))
                            .frame(width: 15, height: 15)
                        
                        Spacer().frame(width: 20)
                        
                        VStack(alignment: .leading) {
                            Text(task.title ?? "")
                                .multilineTextAlignment(.leading)
                                .frame(width: 150, height: 40)
                                .padding(.top, -10)
                                .foregroundColor(Color(.label))
                            if let dueDate = task.dueDate {
                                Text("Due: \(dueDate, formatter: dateFormatter)")
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, -15)
                                    .font(.caption)
                                    .frame(width: 150)
                                    .foregroundColor(dueDate < Date() ? .red : .secondary)
                            }
//                                        else{
//                                            let newDueDate = task.newDueDate {
//                                                Text("Due: \(newDueDate, formatter: dateFormatter)")
//                                                    .multilineTextAlignment(.leading)
//                                                    .padding(.top, -15)
//                                                    .font(.caption)
//                                                    .frame(width: 150)
//                                                    .foregroundColor(newDueDate < Date() ? .red : .secondary)
//                                            }
//                                        }
                        }
                        
                        ToDoToggel(completedTask: task)
                            .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                        
                        Spacer()
                        
                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                            .padding()
                            .frame(width: 30, height: 30)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                            .onTapGesture {
                                selectedTask = task
                                isRenamingTask = true
                            }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Green").opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .onDelete(perform: deleteTask)
                .listStyle(SidebarListStyle())
                .frame(width: 365,height: 35)
                .fullScreenCover(item: $selectedTask) { task in
                    RenameTaskView(task: task)
                }
            }
            
        }
        

    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct CompletedItemView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedItemView()
    }
}
