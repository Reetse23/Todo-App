//
//  HomeView.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

struct PrioritiesView: View {
    @State private var modalShow = false
    @State private var showModal = false
    
    var body: some View {
        VStack{
            NavigationView{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ScrollView(.vertical, showsIndicators: false){
                            Text("Priorities")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.label))
                                .padding(.leading, -180)
                                .padding(.bottom, -5)
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack {
                                    NavigationLink(destination: RedView()) {
                                    RoundedRectangle(cornerRadius:10)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color("Color"),Color("High Priority"),Color("Color")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                                        .frame(width: 150, height: 150)
                                        .overlay(
                                            Circle()
                                                .trim(from: 0, to: 0.8)
                                                .stroke(Color.red, lineWidth: 5)
                                                .frame(width: 80, height: 80)
                                                .rotationEffect(.degrees(90))
                                                .overlay(
                                                    Text("HIGH")
                                                        .font(.headline)
                                                        .foregroundColor(Color.white)
                                                )
                                                .foregroundColor(Color(.systemRed))
                                        )
                                }
                                    NavigationLink(destination: OrangeView()) {
                                        RoundedRectangle(cornerRadius:10)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color("Color"),Color("Medium Priority"),Color("Color")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                                            .frame(width: 150, height: 150)
                                            .overlay(
                                                Circle()
                                                    .trim(from: 0, to: 0.8)
                                                    .stroke(Color.orange, lineWidth: 5)
                                                    .frame(width: 80, height: 80)
                                                    .rotationEffect(.degrees(90))
                                                    .overlay(
                                                        Text("MEDIUM")
                                                            .font(.headline)
                                                            .foregroundColor(Color.white)
                                                    )
                                            )
                                    }
                                    NavigationLink(destination: GreenView()) {
                                        RoundedRectangle(cornerRadius:10)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color("Color"),Color("Low Priority"),Color("Color")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                                            .frame(width: 150, height: 150)
                                            .overlay(
                                                Circle()
                                                        .trim(from: 0, to: 0.8)
                                                        .stroke(Color.green, lineWidth: 5)
                                                        .frame(width: 80, height: 80)
                                                        .rotationEffect(.degrees(90))
                                                        .overlay(
                                                            Text("LOW")
                                                                .font(.headline)
                                                                .foregroundColor(Color.white)
                                                        )
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 5)
                        }
                    }
                    .padding(.top, 5)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .background{
                        ZStack{
                            VStack{
                                Circle ()
                                    .fill (Color("Color"))
                                    .scaleEffect (0.6)
                                    .offset(x: 20)
                                    .blur(radius: 120)
                            }
                        }
                        .ignoresSafeArea()
                    }
                    
                    VStack{
                        Text("Favorites")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.label))
                            .padding(.leading, -180)
                            .padding(.bottom, -5)
                        
                        //NavigationLink(destination: OrangeView()) {
                        RoundedRectangle(cornerRadius:10)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color("Color"),Color.pink,Color("Color")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            .frame(width: 380, height: 150)
                            .overlay(
                                Circle()
                                    .trim(from: 0.1, to: 0.4)
                                    .stroke(Color.red, lineWidth: 5)
                                    .frame(width: 140, height: 140)
                                    .rotationEffect(.degrees(90))
                                    .overlay(
                                        Text("FAVORITES")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                    )
                            )
                            .overlay(
                                Circle()
                                    .trim(from: 0.6, to: 0.9)
                                    .stroke(Color.red, lineWidth: 5)
                                    .frame(width: 140, height: 140)
                                    .rotationEffect(.degrees(90))
                                    
                            )
                    }

                }
            }
        }
    }
}

struct PrioritiesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
