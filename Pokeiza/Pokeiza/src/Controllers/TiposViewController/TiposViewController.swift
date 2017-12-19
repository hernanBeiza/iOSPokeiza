//
//  TiposViewController.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/15/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import UIKit

class TiposViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, TipoDAODelegate {

    @IBOutlet weak var tiposTableView:UITableView!;

    var tipos:[Tipo] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tipos de Pokemon";
        self.navigationController?.navigationBar.tintColor = UIColor.white;

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear");
        let dao:TipoDAO = TipoDAO();
        dao.delegate = self;

        self.tiposTableView.isUserInteractionEnabled = false;
        dao.cargarTipos();
        CargadorView.sharedInstance.mostrarEn(parentView: self.view);
    }
    
    // MARK: TiposDAODelegate
    public func tipoDAOCargados(tipoDAO: TipoDAO,tipos:[Tipo]) {
        print("TiposViewController: tiposDAOCargados");
        //print(tipos);
        self.tiposTableView.isUserInteractionEnabled = true;
        self.tipos = tipos;
        self.tiposTableView.reloadData();
        CargadorView.sharedInstance.ocultar();
    }
    
    public func tipoDAOError(tipoDAO: TipoDAO, error:Error) {
        print("TiposViewController: tiposDAOError");
        print(error.localizedDescription);
        CargadorView.sharedInstance.ocultar();
    }
    
    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tipos.count;
    }
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constantes.AltoCelda;
    }

    public func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)
        let model:Tipo = self.tipos[indexPath.row];
        cell.textLabel?.text = model.nombre;
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("diSelectRowAt",indexPath.row);
        let story:UIStoryboard = self.storyboard!;
        let controller:PokemonesViewController = story.instantiateViewController(withIdentifier: "PokemonesViewController") as! PokemonesViewController;
        controller.iniciarConTipo(tipo: self.tipos[indexPath.row]);
        self.navigationController?.pushViewController(controller, animated: true);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
