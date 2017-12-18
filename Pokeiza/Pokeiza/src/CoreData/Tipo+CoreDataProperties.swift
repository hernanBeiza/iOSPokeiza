//
//  Tipo+CoreDataProperties.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/17/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation
import CoreData


extension Tipo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tipo> {
        return NSFetchRequest<Tipo>(entityName: "Tipo");
    }

    @NSManaged public var nombre: String
    @NSManaged public var url: String?
    @NSManaged public var idTipo: Int16

}
