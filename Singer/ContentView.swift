// MARK: ContentView.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/dynamically-filtering-fetchrequest-with-swiftui
 
 One of the SwiftUI questions I have been asked more than any other is this :
 _How can I dynamically change a Core Data @FetchRequest_
 _to use a different predicate or sort order ?_
 The question arises because fetch requests are created as a property ,
 so
 if you try to make them reference another property
 Swift will refuse .
 There is a simple solution here ,
 and it is usually pretty obvious in retrospect
 because it is exactly how everything else works :
 we should carve off the functionality we want into a separate view ,
 then inject values into it .
 */

import SwiftUI
import CoreData



struct ContentView: View {
    
     // ///////////////////////
    // MARK: PROPERTY WRAPPERS
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
//    @FetchRequest(entity : Singer.entity() ,
//                  sortDescriptors : [] ,
//                  predicate : nil) var singers: FetchedResults<Singer>
    
    @State private var lastNameFilter = "A"
    
    
    
    
     // /////////////////////////
    // MARK: COMPUTED PROPERTIES

    var body: some View {
        
        VStack(spacing : 20) {
            // FilteredListView(filter : lastNameFilter)
            FilteredListView(filter : lastNameFilter , with : "BEGINSWITH")
            Group {
                Button("Create Singers") {
                    let taylor: Singer = Singer(context : managedObjectContext)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"
                    
                    let ed = Singer(context : managedObjectContext)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"
                    
                    let adele = Singer(context : managedObjectContext)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    try? managedObjectContext.save()
                }
                Button("Show A") {
                    self.lastNameFilter = "A"
                }
                Button("Show S") {
                    self.lastNameFilter = "S"
                }
            }
            .font(.title)
        }
    }
    
    
    
     // /////////////////////////
    // MARK: INITIALIZER METHODS
    
    init() {}
}





 // ///////////////
//  MARK: PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
