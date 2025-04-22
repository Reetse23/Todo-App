//
//  ContentView.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

enum Priority: String, Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Priority {
    
    var title: String {
        switch self {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
        }
    }
}

struct ContentView: View {
    @State private var showMenu = false
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .medium
    @Environment(\.managedObjectContext) private var viewContext
    @State private var modalShow = false
    @State private var showModal = false
    
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
        NavigationView {
            ZStack{
                
                VStack{
                    PrioritiesView()
                }
                .padding(.top, 45)
                VStack {
                    HStack {
                        Image("Tick") // replace "logo" with the name of your image file
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.leading, 25)
                            .padding(.top, -2)
                            
                        Text("To-do List")
                            .font(.system(size: 25))
                            .foregroundColor(Color(.label))
                        Spacer()
                    }
                    .padding(.leading, -15)
                    .padding(.top, -395)
                }
                
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("ButtonColor1"),Color("ButtonColor"),Color("ButtonColor1")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            .frame(width: 100, height: 40)
                            .overlay(
                                Button(action: { showModal = true}){
                                    Image("Pen")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                }
                            )
                    }
                    Spacer()
                    SaveTask(isShown: $showModal)
                        .padding(.leading, 285)
                        .padding(.bottom, 50)
                }
                
                .padding(.leading, -285)
                
                VStack{
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("ButtonColor1"),Color("ButtonColor"),Color("ButtonColor1")]), startPoint: .bottomLeading, endPoint: .topTrailing))
                            .frame(width: 280,height: 40)
                            .overlay(
                                Button(action: { modalShow = true }){
                                    Text("SHOW ALL ITEMS")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                }
                            )
                    }
                    Spacer()
                    All_priorities(isShown: $modalShow)
                        .padding(.trailing, 105)
                        .padding(.bottom, -90)
                }
                .padding(.trailing, -105)
            }
            .padding(.top, 40)
        }
        .padding(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistedContainer = CoreDataManager.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, persistedContainer.viewContext)
    }
}
