//
//  DetalleViewController.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/15/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import UIKit

class DetalleViewController: UIViewController, PokemonDAODelegate {

    @IBOutlet weak var fotoImageView:UIImageView!;
    @IBOutlet weak var tipoLabel:UILabel!;
    @IBOutlet weak var pesoLabel:UILabel!;
    @IBOutlet weak var tamanoLabel:UILabel!;
    @IBOutlet weak var habilidadesTextView:UITextView!;
    @IBOutlet weak var caracteristicasTextView:UITextView!;

    //TODO: Crear Constraints en el Storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        tipoLabel.text = "";
        pesoLabel.text = "";
        tamanoLabel.text = "";
        habilidadesTextView.text = "";
        caracteristicasTextView.text = "";
    }
    
    public func iniciarConPokemon(pokemon:Pokemon){
        self.title = pokemon.nombre;
        let dao:PokemonDAO = PokemonDAO();
        dao.delegate = self;
        dao.cargarPokemon(pokemon: pokemon);
    }
    
    func pokemonDAOCargado(pokemonDAO:PokemonDAO,pokemon:Pokemon) {
        print("DetalleViewController: pokemonDAOCargado();");
        self.tipoLabel.text = pokemon.tipos;
        self.pesoLabel.text = pokemon.peso;
        self.tamanoLabel.text = pokemon.tamano;
        self.habilidadesTextView.text = pokemon.habilidades;
        self.caracteristicasTextView.text = pokemon.caracteristicas;
    }
    
    func pokemonDAOError(pokemonDAO:PokemonDAO,error:Error) {
        print(error.localizedDescription);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
