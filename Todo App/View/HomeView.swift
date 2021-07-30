//
//  HomeView.swift
//  Todo App
//
//  Created by datNguyen on 7/29/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeData = HomeViewModel()
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "createAt", ascending: true)], animation: .spring()) var results: FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            //body
            VStack{
                //header
                HStack{
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color(.white))
                //list
                //if results empty return blank
                if(results.isEmpty){
                    Spacer()
                    
                    Text("No Task!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                else{
                    ScrollView(.vertical, showsIndicators: false, content: {
                        LazyVStack(alignment: .leading, spacing: 20, content: {
                            ForEach(results){ obj in
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(obj.title ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text(obj.createAt ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                    
                                    Divider()
                                        .padding(2)
                                        .foregroundColor(.black)
                                })
                                .foregroundColor(.black)
                                .contextMenu(ContextMenu(menuItems: {
                                    Button(action: {homeData.updateData(itemUpdate: obj)}, label: {
                                        Text("Edit")
                                            .foregroundColor(.white)
                                            .background(Color(.red))
                                    })
                                    Button(action: {homeData.delete(itemDelete: obj, context: context)}, label: {
                                        Label("Delete", systemImage: "trash")
                                    })
                                    
                                    
                                }))
                            }
                        })
                        .padding()
                    })
                }
            }
            //bottom butotn
            Button(action: {
                
                    homeData.isNewData.toggle()
            }, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        AngularGradient(gradient: .init(colors: [Color("Color"), Color("Color1")]), center: .center)
                            .clipShape(Circle())
                    )
            })
            .padding()
            
            
        })
        .background(Color(.black).opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
        .sheet(isPresented: $homeData.isNewData, onDismiss: {
            homeData.updateItem = nil
            homeData.resetFormData()
        }, content: {
            NewDataView(homeData: homeData)
        })
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


