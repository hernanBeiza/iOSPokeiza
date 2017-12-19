//
//  LocalDBDAO.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/15/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import UIKit
import CoreData

class LocalDBDAO: NSObject {

    override init(){
        print("LocalDBDAO: init();");
    }
    
    public func guardarTipo(idTipo:Int,nombre:String,url:String) -> Bool {
        print("TiposDAO: guardarTipo(); \(nombre)");
        if (self.obtenerTipo(nombre: nombre) != nil){
            print("No Guardar: Ya Existe Tipo \(nombre)");
            return false;
        } else {
            print("Guardar Tipo: \(nombre)");
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let model:Tipo = Tipo(context: managedContext);
            model.idTipo = Int16(idTipo);
            model.nombre = nombre;
            model.url = url;
            /*
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // 1
            let managedContext = appDelegate.persistentContainer.viewContext
            // 2
            let entity = NSEntityDescription.entity(forEntityName: "Tipo", in: managedContext)!
            let tipo = NSManagedObject(entity: entity, insertInto: managedContext)
            // 3
            tipo.setValue(model.nombre, forKeyPath: "nombre")
            tipo.setValue(model.url, forKeyPath: "url")
            // 4
            */
            do {
                try managedContext.save()
                print("Tipo guardado correctamente en CoreData");
                return true;
            } catch let error as NSError {
                print("Tipo no se pudo guardar en CoreData: \(error), \(error.userInfo)");
                return false;
            }
        }
    }
    
    public func obtenerTipo(nombre:String) ->Tipo? {
        print("TiposDAO: obtenerTipo \(nombre)");
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //2        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tipo")
        fetchRequest.predicate = NSPredicate(format: "nombre == %@", nombre);
        //3
        do {
            let tiposObtenidos = try managedContext.fetch(fetchRequest) as NSArray;
            print(tiposObtenidos.count);
            if(tiposObtenidos.count>0){
                let model:Tipo = tiposObtenidos.firstObject as! Tipo;
                print ("Se encontró el Tipo \(nombre)");
                return model;
            } else {
                print ("No se encontró el Tipo \(nombre)");
                return nil;
            }
        } catch let error as NSError {
            print("No se pudo obtener tipo \(nombre), \(error), \(error.userInfo)");
            return nil;
        }
    }
    
    public func obtenerTipos() ->[Tipo]? {
        print("TiposDAO: obtenerTipos();");
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tipo")
        //3
        do {
            let tiposObtenidos = try managedContext.fetch(fetchRequest) as! [Tipo]
            print("Total de tipos: \(tiposObtenidos.count)");
            if(tiposObtenidos.count>0){
                /*
                var tipos:[TipoModel] = [];
                for item in tiposObtenidos {
                    let tipo:Tipo = item as Tipo;
                    let model:TipoModel = TipoModel(nombre: tipo.nombre!, url: tipo.url!);
                    tipos.append(model);
                }
                */
                return tiposObtenidos;
            } else {
                print ("No se encontraron tipos");
                return nil;
            }
        } catch let error as NSError {
            print("No se pudo obtener los tiposre), \(error), \(error.userInfo)");
            return nil;
        }
    }
    
    
    //MARK: Eliminar los tipos en CoreData
    public func eliminarTipos() -> Bool {
        print("TiposDAO: eliminarTipos();");
        
        return false;
    }
    
    //MARK: Guardar Pokemon
    public func guardarPokemon(idPokemon:Int,idTipo:Int,nombre:String,tamano:String?,peso:String?,caracteristicas:String?,habilidades:String?,tipos:String?,fotografia:String?) -> Bool {
        print("TiposDAO: guardarTipo(); \(nombre)");
        if (self.obtenerPokemon(idPokemon: idPokemon) != nil){
            print("No Guardar: Ya Existe Pokemon con id \(idPokemon)");
            return false;
        } else {
            print("Guardar Pokemon: \(nombre)");
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let model:Pokemon = Pokemon(context: managedContext);
            model.idPokemon = Int16(idPokemon);
            model.idTipo = Int16(idTipo);
            model.nombre = nombre;
            model.tamano = tamano;
            model.peso = peso;
            model.caracteristicas = caracteristicas;
            model.habilidades = habilidades;
            model.tipos = tipos;
            model.fotografia = fotografia;
            do {
                try managedContext.save()
                print("Pokemon guardado correctamente en CoreData");
                return true;
            } catch let error as NSError {
                print("Pokemon no se pudo guardar en CoreData: \(error), \(error.userInfo)");
                return false;
            }
        }
    }

    public func editarPokemon(idPokemon:Int,idTipo:Int,nombre:String,tamano:String,peso:String,caracteristicas:String,habilidades:String,tipos:String,fotografia:String?) -> Bool {
        print("LoocalDBDAO: editarPokemon(); \(nombre)");
        if var model:Pokemon = self.obtenerPokemon(idPokemon: idPokemon){
            model.idPokemon = Int16(idPokemon);
            model.idTipo = Int16(idTipo);
            model.nombre = nombre;
            model.tamano = tamano;
            model.peso = peso;
            model.caracteristicas = caracteristicas;
            model.habilidades = habilidades;
            model.tipos = tipos;
            model.fotografia = fotografia;
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            do {
                try managedContext.save();
                return true;
            } catch let error as NSError {
                print(error.localizedDescription);
                return false;
            }
        } else {
            return false;
        }
    }
    
    public func obtenerPokemonConTipo(idTipo:Int) -> [Pokemon] {
        print("LocalDBDAO: obtenerPokemonConTipo \(idTipo)");
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
        fetchRequest.predicate = NSPredicate(format: "idTipo == %@", String(idTipo));
        //3
        do {
            let pokemones = try managedContext.fetch(fetchRequest);
            if(pokemones.count>0){
                print ("LocalDBDAO: Se encontró un total de \(pokemones.count) pokemones con idTipo \(idTipo)");
                return pokemones as! [Pokemon];
            } else {
                print ("LocalDBDAO: No se encontraron pokemones con idTipo: \(idTipo)");
                return [];
            }
        } catch let error as NSError {
            print("LocalDBDAO: No se pudo obtener los pokemones con idPokemon: \(idTipo), \(error), \(error.userInfo)");
            return [];
        }
    }
    
    public func obtenerPokemon(idPokemon:Int) ->Pokemon? {
        print("LocalDBDAO: obtenerPokemon();");
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
        fetchRequest.predicate = NSPredicate(format: "idPokemon == %@", String(idPokemon));
        do {
            let pokemones = try managedContext.fetch(fetchRequest) as NSArray;
            if(pokemones.count>0){
                if let pokemon:Pokemon = pokemones.firstObject as? Pokemon {
                    print ("LocalDBDAO: Se encontró a \(pokemon.nombre)");
                    return pokemon;
                } else {
                    print ("LocalDBDAO: No se encontraron pokemones con idPokemon: \(idPokemon)");
                    return nil;
                }
            } else {
                print ("LocalDBDAO: No se encontraron pokemones con idPokemon: \(idPokemon)");
                return nil;
            }
        } catch let error as NSError {
            print("LocalDBDAO: No se pudo obtener pokemon con idPokemon: \(idPokemon), \(error), \(error.userInfo)");
            return nil;
        }
    }
    
    public func obtenerDetallePokemon(idPokemon:Int) -> Pokemon? {
        print("LocalDBDAO: obtenerDetallePokemon();");

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pokemon")
        var subPredicates : [NSPredicate] = [];
        subPredicates.append(NSPredicate(format: "idPokemon == %@", String(idPokemon)));
        subPredicates.append(NSPredicate(format: "caracteristicas != nil"));

        //fetchRequest.predicate = NSPredicate(format: "idPokemon == %@", String(idPokemon));
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)

        do {
            let pokemones = try managedContext.fetch(fetchRequest) as NSArray;
            if(pokemones.count>0){
                if let pokemon:Pokemon = pokemones.firstObject as? Pokemon {
                    print ("LocalDBDAO: Se encontró detalle de Pokemon \(pokemon.nombre)");
                    return pokemon;
                } else {
                    print ("LocalDBDAO: No se encontró detalle de Pokemon con idPokemon: \(idPokemon)");
                    return nil;
                }
            } else {
                print ("LocalDBDAO: No se encontró detalle de Pokemon con idPokemon: \(idPokemon)");
                return nil;
            }
        } catch let error as NSError {
            print("LocalDBDAO: No se pudo obtener detalle de Pokemon con idPokemon: \(idPokemon), \(error), \(error.userInfo)");
            return nil;
        }
    }
    
    deinit {
        print(String(describing: LocalDBDAO.self), #function);
    }

}
