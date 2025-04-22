//
//  ScreenView.swift
//  ToDoApp
//
//  Created by Thabiso Gaereetse on 2023/03/14.
//
import SwiftUI
var totalPages = 3

struct OnboardingScreen: View {
    @AppStorage("currentPage") var currentPage = 1
    
    @State var textFieldText: String = ""
    @State var dataArray: [String] = []
    
    @State private var userName: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var oneTask: FetchedResults<User>
    
    private func saveUser(){
        do {
            let user = User(context: viewContext)
            user.userName = userName
            user.dateCreated = Date()
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View{
        
            ZStack{
                
                if currentPage == 1{
                    ScreenView(imageO: "Welcome-amico", titleO: "Welcome to your To-Do App!", detailsO: "The best app to get stuff done in.")
                }
                
                if currentPage == 2{
                    ScreenView(imageO: "Filing system-amico", titleO: "Prioritize what goes first!", detailsO: "The perfect place to have you catogorized daily forgetable errands at an easy reach.")
                }
                
                if currentPage == 3{
                    VStack{
                        ScreenView(imageO: "Writing on the wall-bro", titleO: "Add your name!", detailsO: "This is the name which will be displayed in the home page.")
                    }
                    
                    VStack{
                        TextField("Type your name..", text: $userName)
                            //.padding(.top, 250)
                            .shadow(color: Color.black ,radius: 1)
                            .textFieldStyle(.roundedBorder)
                            //.cornerRadius(0)

                        Button(action: {
                            saveUser()
                        }, label: {
                            Text("Save".uppercased())
                                .frame(width: 60)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .cornerRadius(40)
                        })
                        ForEach(oneTask){ user in
                            VStack{
                                HStack{
                                    Text("That's a nice name,")
                                    Text(user.userName ?? "")
                                        .padding(.leading, -5)
                                        .foregroundColor(Color.green)
                                }
                                .foregroundColor(Color(.label))
                                .padding(.top)
                                Text("Now click the 'Next' button to finish")
                            }
                            
                        }
                    }
                    .padding(.top, 450)
                    
                }
            }
    }
}

struct ScreenView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    var imageO: String
    var titleO: String
    var detailsO: String
    
    
    var body: some View {
       
            VStack{
                HStack{
                    if currentPage == 1 {
                        Text("TO-DO APP")
                            .font(.title2)
                            .fontWeight(.semibold)
                            
                    }else{
                        Button(action: {
                            currentPage -= 1
                        }, label: {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 40, height: 40)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("Plus Button"), Color("Green"), Color("Green")]), startPoint: .topTrailing, endPoint: .bottom))
                                .overlay(
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(Color.white)
                                )
                        })
                    }
                    Spacer()
                    if currentPage == 3 {
                        Text("")
                            
                    }else{
                        Button(action: {
                            currentPage = 3
                        }, label: {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 60, height: 40)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("Plus Button"), Color("Green"), Color("Green")]), startPoint: .topTrailing, endPoint: .bottom))
                                .overlay(
                                    Text("SKIP")
                                        .foregroundColor(Color.white)
                                )
                        })
                    }
                }
                .padding(.horizontal)
                Image(imageO)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .cornerRadius(30)
                
                Text(titleO)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.green)
                
                
                Text(detailsO)
                    .font(.subheadline)
                    .frame(width: 300)
                Spacer()
                Button(action: {
                    if currentPage <= totalPages {
                        currentPage += 1
                        
                    }
                    else
                    {
                        currentPage = 1
                    }
                }, label: {
                    Text("Next")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .cornerRadius(40)
                })
            }
        
    }
}
