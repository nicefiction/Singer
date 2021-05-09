// MARK: Singer+CoreDataProperties.swift

import Foundation
import CoreData



extension Singer {

    @nonobjc public class func fetchRequest()
    -> NSFetchRequest<Singer> {
        
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var wrappedFirstName: String {
        
        return firstName ?? "N/A"
    }
    
    
    var wrappedLastName: String {
        
        return lastName ?? "N/A"
    }

}



extension Singer : Identifiable {}
