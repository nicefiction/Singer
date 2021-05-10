// MARK: FilteredListView.swift
/**
 We want to be able to create a custom fetch request inside an initializer :
 */

import SwiftUI
import CoreData



struct FilteredListView: View {
    
     // /////////////////
    //  MARK: PROPERTIES
    
    var fetchRequest: FetchRequest<Singer>
    /**
     That will store our fetch request ,
     so that we can loop over it inside the `body` .
     However , we don’t create the fetch request here ,
     because we still don’t know what we are searching for .
     Instead , we are going to create a custom initializer
     that accepts a `filter` string
     and uses that to set the `fetchRequest` property .
     */
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    /**
     If you don’t like using `fetchRequest.wrappedValue` in `ForEach`,
     you could create a simple computed property like this :
     */
    var singers: FetchedResults<Singer> {
        
        return fetchRequest.wrappedValue
    }
    
    
    var body: some View {
        
        List {
            ForEach(singers , id : \.self) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
        }
    }
    
    
    
     // //////////////////////////
    //  MARK: INITIALIZER METHODS
    
    init(filter: String , with predicateOperator: String) {
        fetchRequest = FetchRequest(entity : Singer.entity() ,
                                    sortDescriptors : [NSSortDescriptor(keyPath : \Singer.firstName , ascending : true)] ,
                                    // predicate : NSPredicate(format : "lastName BEGINSWITH %@" , filter))
        /**
         That will run a fetch request
         using the current managed object context .
         Because this view will be used inside `ContentView` ,
         we don’t even need to inject a managed object context into the environment
         — it will inherit the context from `ContentView` .
         */
                                    predicate : NSPredicate(format : "lastName \(predicateOperator) %@" , filter))
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct FilteredListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FilteredListView(filter : "A" , with : "BEGINSWITH")
    }
}
