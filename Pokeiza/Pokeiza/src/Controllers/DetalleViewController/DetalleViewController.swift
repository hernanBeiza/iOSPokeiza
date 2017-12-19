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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }

    override func viewWillAppear(_ animated: Bool) {
        tipoLabel.text = "";
        pesoLabel.text = "";
        tamanoLabel.text = "";
        habilidadesTextView.text = "";
        caracteristicasTextView.text = "";
    }
    
    public func iniciarConPokemon(pokemon:Pokemon){
        CargadorView.sharedInstance.mostrarEn(parentView: self.view);
        self.title = pokemon.nombre;
        let dao:PokemonDAO = PokemonDAO();
        dao.delegate = self;
        dao.cargarPokemon(pokemon: pokemon);
    }
    
    func pokemonDAOCargado(pokemonDAO:PokemonDAO,pokemon:Pokemon) {
        print("DetalleViewController: pokemonDAOCargado();");
        CargadorView.sharedInstance.ocultar();
        self.tipoLabel.text = pokemon.tipos;
        self.pesoLabel.text = pokemon.peso;
        self.tamanoLabel.text = pokemon.tamano;
        self.habilidadesTextView.text = pokemon.habilidades;
        self.caracteristicasTextView.text = pokemon.caracteristicas;
        if(pokemon.fotografia != nil){
            self.fotoImageView.downloadImage(url: pokemon.fotografia!);
        }
    }
    
    func pokemonDAOError(pokemonDAO:PokemonDAO,error:Error) {
        CargadorView.sharedInstance.ocultar();
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
