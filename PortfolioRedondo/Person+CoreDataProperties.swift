//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Akhelys Redondo on 11/1/20.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int64

}
