//
//  HomeViewModel.swift
//  Todo App
//
//  Created by datNguyen on 7/29/21.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    
    
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var createAt: Date = Date()
    
    //isNewData is state to open NewDataView
    @Published var isNewData = false
    
    //Storing data of update item..
    @Published var updateItem: Task?
    
    //Checking and updating "Date"...
    let calendar = Calendar.current
    
    func checkDate() -> String {
        if calendar.isDateInToday(createAt) {
            return "Today"
        }
        else if calendar.isDateInTomorrow(createAt) {
            return "Tomorrow"
        }
        else {
            return "Another day"
        }
    }
    
    func updateDate(value: String){
        if value == "Today" {
            createAt = Date()
        }
        else if value == "Tomorrow" {
            createAt = calendar.date(byAdding: .day, value: 1, to: Date())!
        } else {
            
        }
    }
    
    func createData(context: NSManagedObjectContext){
        if(updateItem != nil){
            updateItem!.title = title
            updateItem!.content = content
            updateItem!.createAt = createAt
            
            saveContext(context: context)
            updateItem = nil
            isNewData.toggle()
            return
        }
        else {
            let newTask = Task(context: context)
            newTask.title = title
            newTask.content = content
            newTask.createAt = createAt
            
            saveContext(context: context)
            isNewData.toggle()
        }
               
        

    }
    
    func delete(itemDelete: NSManagedObject, context: NSManagedObjectContext){
        context.delete(itemDelete)
        saveContext(context: context)
    }
    
    func updateData(itemUpdate: Task){
        updateItem = itemUpdate
        //Now togging the newDataView
        self.title = updateItem!.title!
        self.content = updateItem!.content!
        self.createAt = updateItem!.createAt!
        isNewData.toggle()
    }
    
    func resetFormData(){
        self.title = ""
        self.content = ""
        self.createAt = Date()
    }
    
    
    
    func saveContext(context: NSManagedObjectContext){
        do {
            if context.hasChanges {
                try context.save()
//                print(newTask.description)
                resetFormData()
                
            }
        } catch {
            print("error when save data: \(error.localizedDescription)")
        }
    }
    
}

