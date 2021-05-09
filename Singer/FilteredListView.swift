// MARK: FilteredListView.swift

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
     that accepts a filter string
     and uses that to set the `fetchRequest` property .
     */
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var singers: FetchedResults<Singer> {
        
        return fetchRequest.wrappedValue
    }
    
    
    var body: some View {
        
        List {
            ForEach(singers , id : \.self) { (singer: Singer) in
                Text("\(singer.computedFirstName) \(singer.computedLastName)")
            }
        }
    }
    
    
    
     // //////////////////////////
    //  MARK: INITIALIZER METHODS
    
    init(filter: String) {
        fetchRequest = FetchRequest(entity : Singer.entity() ,
                                    sortDescriptors : [] ,
                                    predicate : NSPredicate(format : "lastName BEGINSWITH %@" , filter))
        /**
         That will run a fetch request
         using the current managed object context .
         Because this view will be used inside `ContentView` ,
         we don’t even need to inject a managed object context into the environment
         — it will inherit the context from `ContentView` .
         */
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct FilteredListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        FilteredListView(filter : "A")
    }
}
