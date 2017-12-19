//
//  PokemonDAO.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/17/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation

//MARK: Protocolo PokemonDAO
protocol PokemonDAODelegate: class {
    func pokemonDAOCargado(pokemonDAO:PokemonDAO,pokemon:Pokemon);
    func pokemonDAOError(pokemonDAO:PokemonDAO,error:Error);
}

class PokemonDAO: NSObject, URLSessionDelegate {
    
    weak var delegate: PokemonDAODelegate?
    
    override init() {
        print("PokemonDAO:",#function);
    }
    
    //MARK: Obtener los tipos de pokemones desde la API.
    public func cargarPokemon(pokemon:Pokemon){
        print("PokemonDAO:",#function);
        let dao:LocalDBDAO = LocalDBDAO();
        if let model = dao.obtenerDetallePokemon(idPokemon: Int(pokemon.idPokemon)){
            DispatchQueue.main.async() {
                self.delegate?.pokemonDAOCargado(pokemonDAO: self, pokemon: model);
            }
        } else {
            self.cargarDesdeInternet(pokemon:pokemon);
        }
    }
    
    private func cargarDesdeInternet(pokemon:Pokemon){
        print("PokemonDAO:",#function);
        let url = URL(string: Constantes.URLPokemon+String(pokemon.idPokemon));
        print(url!);
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary {
                    //print(json);
                    print("tipo \(pokemon.idTipo)");
                    let peso:Int = json.value(forKey: "weight") as! Int;
                    let pesoString:String = String(describing:peso);
                    print("peso \(pesoString)");
                    
                    let tamano:Int = json.value(forKey: "height") as! Int;
                    let tamanoString:String = String(describing:tamano);
                    print("tamaño \(tamanoString)");

                    let caracteristicasJSON = json.value(forKey: "stats") as! NSArray;
                    //print(caracteristicasJSON);
                    var caracteristicaString:String = "";
                    var i = 0;
                    for caracteristica in caracteristicasJSON {
                        let caracteristicaDIC:NSDictionary = caracteristica as! NSDictionary
                        let stat:NSDictionary = caracteristicaDIC.value(forKey: "stat") as! NSDictionary;
                        caracteristicaString.append(String(stat.value(forKey: "name") as! String).capitalized);
                        if(i<caracteristicasJSON.count-1){
                            caracteristicaString.append("\n");
                        }
                        i+=1;
                    }
                    
                    print("características \(caracteristicaString)");
                    
                    let habilidadesJSON = json.value(forKey:"abilities") as! NSArray;
                    var habilidadesString:String = "";
                    i = 0;
                    for habilidad in habilidadesJSON {
                        let habilidadDIC:NSDictionary = habilidad as! NSDictionary
                        let habilidad:NSDictionary = habilidadDIC.value(forKey: "ability") as! NSDictionary;
                        habilidadesString.append(String(habilidad.value(forKey: "name") as! String).capitalized);
                        if(i<habilidadesJSON.count-1){
                            habilidadesString.append("\n");
                        }
                        i+=1;
                    }
                    
                    print("habilidades \(habilidadesString)");

                    let tiposJSON = json.value(forKey:"types") as! NSArray;
                    var tiposString:String = "";
                    i = 0;
                    for tipo in tiposJSON {
                        let tipoDIC:NSDictionary = tipo as! NSDictionary
                        let tipo:NSDictionary = tipoDIC.value(forKey: "type") as! NSDictionary;
                        tiposString.append(String(tipo.value(forKey: "name") as! String).capitalized);
                        if(i<tiposJSON.count-1){
                            tiposString.append("/");
                        }
                        i+=1;
                    }
                    
                    print("tipos \(tiposString)");
                    
                    let foto:NSDictionary = json.value(forKey:"sprites") as! NSDictionary;
                    var fotoString: String? = nil;
                    if let foto = foto.value(forKey: "front_default") as? String {
                        fotoString = foto;
                    }
                    let local:LocalDBDAO = LocalDBDAO();
                    if(local.editarPokemon(idPokemon: Int(pokemon.idPokemon), idTipo: Int(pokemon.idTipo), nombre: pokemon.nombre, tamano: tamanoString, peso: pesoString, caracteristicas: caracteristicaString, habilidades: habilidadesString, tipos: tiposString, fotografia: fotoString)){
                        //print("Pokemon \(pokemon.nombre) Actualizado");
                        if let pokemonModel:Pokemon = local.obtenerPokemon(idPokemon: Int(pokemon.idPokemon)){
                            DispatchQueue.main.async() {
                                self.delegate?.pokemonDAOCargado(pokemonDAO: self, pokemon: pokemonModel);
                            }
                        }
                    } else {
                        print("Pokemon \(pokemon.nombre) No Actualizado.");
                    };
                }
                
            } else {
                DispatchQueue.main.async() {
                    self.delegate?.pokemonDAOError(pokemonDAO: self, error: error!);
                }
            }
        }
        task.resume();

    }
    
}
