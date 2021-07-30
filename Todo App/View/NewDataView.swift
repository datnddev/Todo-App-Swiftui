//
//  NewDataView.swift
//  Todo App
//
//  Created by datNguyen on 7/29/21.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData: HomeViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            //heading
            HStack {
                TextField("\(homeData.updateItem == nil ? "Add new task" : "\(homeData.title)")", text: $homeData.title)
                    .font(.system(size: 65, weight: .bold))
                                    
                Spacer(minLength: 0)
            }
            .padding()
            
            Spacer(minLength: 0)
            
            //body
            TextEditor(text: $homeData.content)
                .background(Color(.white))
                .padding()
                
            Divider()
                .padding(.horizontal)
            
            Spacer(minLength: 0)
                
            //bottom button
            HStack{
                Text("When")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                                    
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 20){
                DateButtonView(title: "Today", homeData: homeData)
                
                DateButtonView(title: "Tomorrow", homeData: homeData)
                
                DatePicker("", selection: $homeData.createAt, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()
            
            //add button
            HStack{
                Button(action: {homeData.createData(context: context)}, label: {
                    Label(
                        title: { Text("\(homeData.updateItem == nil ? "Add now" : "Update now")").fontWeight(.bold) },
                        icon: { Image(systemName: "plus") }
                    )
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                        LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    )
                })
                .cornerRadius(8)
                .disabled(homeData.title.isEmpty ? true : false)
                .opacity(homeData.title.isEmpty ? 0.5 : 1)
            }
            
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
        
    }
}

struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        NewDataView(homeData: HomeViewModel())
    }
}
