//
//  Pokemon+CoreDataProperties.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/17/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon");
    }

    @NSManaged public var idPokemon: Int16
    @NSManaged public var idTipo: Int16
    @NSManaged public var nombre: String
    @NSManaged public var tamano: String?
    @NSManaged public var peso: String?
    @NSManaged public var caracteristicas: String?
    @NSManaged public var habilidades: String?
    @NSManaged public var tipos: String?
    @NSManaged public var fotografia: String?

}
