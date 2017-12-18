//
//  TipoDAO.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/15/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import UIKit
import CoreData

//MARK: Protocoles TiposDAO
protocol TipoDAODelegate: class {
    func tipoDAOCargados(tipoDAO:TipoDAO,tipos:[Tipo]);
    func tipoDAOError(tipoDAO:TipoDAO,error:Error);
}

class TipoDAO: NSObject, URLSessionDelegate {

    weak var delegate: TipoDAODelegate?

    //Contador para ir cargando de tipo en tipo
    private var idtipo:Int = 1;
    
    override init() {
        print("TiposDAO: init();");
    }
    
    //MARK: Obtener los tipos de pokemones desde la API.
    public func cargarTipos(){
        print("TiposDAO: cargarTipos();");
        let dao:LocalDBDAO = LocalDBDAO();
        let tipos = dao.obtenerTipos();
        if(tipos == nil){
            self.cargarDesdeInternet();
        } else if (tipos!.count<18){
            self.cargarDesdeInternet();
        } else if (tipos!.count==18){
            DispatchQueue.main.async() {
                self.delegate?.tipoDAOCargados(tipoDAO: self,tipos:tipos!);
            }
        }
    }
    
    private func cargarDesdeInternet(){
        print("TiposDAO: cargarDesdeInternet()");
        let url = URL(string: Constantes.URLTipos+String(self.idtipo));
        print(url!);
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                    //print(json);
                    //print(json!.value(forKey: "results")!);
                    let idTipo = json?.value(forKey:"id") as! Int;
                    //print("idTipo \(idTipo)");
                    let nombres = json?.value(forKey: "names") as! NSArray;
                    let tipoDict = nombres.object(at: 4) as! NSDictionary;
                    //print(tipoDict);
                    let nombre:String = tipoDict.value(forKey: "name") as! String;
                    let language:NSDictionary = tipoDict.value(forKey: "language") as! NSDictionary;
                    let url:String = language.value(forKey: "url") as! String;
                    //print(nombre,url);
                    let local:LocalDBDAO = LocalDBDAO();
                    if(local.guardarTipo(idTipo:idTipo,nombre:nombre,url:url)){
                        //print("Tipo \(nombre) Guardado");
                        let pokemones = json?.value(forKey: "pokemon") as! NSArray;
                        for item in pokemones {
                            let item2:NSDictionary = item as! NSDictionary;
                            let itemPokemon:NSDictionary = item2.value(forKey: "pokemon") as! NSDictionary;
                            let pokemon:NSDictionary = itemPokemon;
                            let dao:LocalDBDAO = LocalDBDAO();
                            let rutaPokemon:String  = itemPokemon.value(forKey:"url") as! String;
                            //print("rutaPokemon \(rutaPokemon)");
                            let rutaSplit:[String] = rutaPokemon.components(separatedBy: "/");
                            //print(rutaSplit);
                            let idPokemon:Int = Int(rutaSplit[rutaSplit.count-2])!;
                            //print("idPokemon \(idPokemon)");
                            let nombre:String = pokemon.value(forKey: "name") as! String;
                            if(dao.guardarPokemon(idPokemon: idPokemon, idTipo: idTipo, nombre: nombre.capitalized, tamano: nil, peso: nil, caracteristicas: nil, habilidades: nil, tipos: nil, fotografia: nil)){
                                print("Pokemon Guardado OK");
                            } else {
                                print("Pokemon No Guardado");
                            }
                        }
                    } else {
                        print("Tipo \(nombre) No Guardado.");
                    };
                    //Cargar siguiente tipo
                    self.idtipo+=1;
                    self.cargarTipos();
                }
            } else {
                DispatchQueue.main.async() {
                    self.delegate?.tipoDAOError(tipoDAO: self,error:error!);
                }
            }
        }
        task.resume();
    }
    
    deinit {
        print(String(describing: LocalDBDAO.self), #function);
    }
    
}
