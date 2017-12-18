//
//  PokemonesViewController.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/15/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import UIKit

class PokemonesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var pokemonesTableView:UITableView!;
    
    private var pokemones:[Pokemon] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pokemonesTableView.reloadData()
    }
    
    public func iniciarConTipo(tipo: Tipo){
        print("iniciarConTipo",tipo.nombre);
        self.title = tipo.nombre;
        self.cargarPokemones(tipo: tipo);
    }
    
    private func cargarPokemones(tipo:Tipo){
        print(String(describing: PokemonesViewController.self),#function);
        let dao:LocalDBDAO = LocalDBDAO();
        pokemones = dao.obtenerPokemonConTipo(idTipo: Int(tipo.idTipo));
        /*
        for pokemon in pokemones {
            print("idPokemon \(pokemon.idPokemon)");
            print("caracteristicas \(pokemon.caracteristicas)");
        }
        */
    }
    
    //MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(String(describing: PokemonesViewController.self), #function, pokemones.count);
        return pokemones.count;
    }
    
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        let model:Pokemon = pokemones[indexPath.row];
        cell.textLabel?.text = model.nombre;
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("diSelectRowAt",indexPath.row);
        let story:UIStoryboard = self.storyboard! as UIStoryboard;
        let controller:DetalleViewController = story.instantiateViewController(withIdentifier: "DetalleViewController") as! DetalleViewController;
        let model:Pokemon = self.pokemones[indexPath.row];
        controller.iniciarConPokemon(pokemon: model);
        self.navigationController?.pushViewController(controller, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

