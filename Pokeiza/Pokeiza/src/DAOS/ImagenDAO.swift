//
//  ImagenDAO.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/19/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation
import UIKit

//MARK: Protocolo PokemonDAO
protocol ImagenDAODelegate: class {
    func imagenDAOCargado(imagenDAO:ImagenDAO,imagenData:Data);
    func imagenDAOError(imagenDAO:ImagenDAO,error:Error);
}

class ImagenDAO: NSObject, URLSessionDelegate {
    
    weak var delegate: ImagenDAODelegate?
    
    override init() {
        //print("ImagenDAO:",#function);
    }
    
    func cargarCon(url:String){
        //print("ImagenDAO:",#function);
        //print(url);
        if let image = self.abrirDesdeDiscoCon(ruta: url){
            DispatchQueue.main.async {
                self.delegate?.imagenDAOCargado(imagenDAO: self, imagenData: image);
            }
        } else {
            URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { data, response, error in
                if(error == nil){
                    if(data != nil){
                        let guardada = self.guardarEnDiscoCon(ruta:url, imagenData:data!);
                        if(guardada){
                            print("ImagenDAO: Imagen Guardada")
                        }
                        DispatchQueue.main.async {
                            self.delegate?.imagenDAOCargado(imagenDAO: self, imagenData: data!);
                        }
                    } else {
                        let info:[String: Any] = ["result": false, "errores":"No cargó la data"];
                        let errorTemp = NSError(domain:"", code:404, userInfo:info)
                        DispatchQueue.main.async {
                            self.delegate?.imagenDAOError(imagenDAO: self, error: errorTemp);
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.imagenDAOError(imagenDAO: self, error: error!);
                    }
                }
                }.resume();
        }
    };
    
    private func guardarEnDiscoCon(ruta:String,imagenData:Data) -> Bool {
        //print("ImagenDAO:",#function);
        let fileManager = FileManager.default;
        let partes = ruta.components(separatedBy: "/");
        if let nombre = partes.last {
            //print(nombre);
            let rutaFinal = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nombre)
            //print(rutaFinal);
            fileManager.createFile(atPath: rutaFinal as String, contents: imagenData, attributes: nil)
            return true;
        } else {
            return false;
        }
    }
    
    private func abrirDesdeDiscoCon(ruta:String) -> Data? {
        //print("ImagenDAO:",#function);
        let fileManager = FileManager.default;
        let partes = ruta.components(separatedBy: "/");
        if let nombre = partes.last {
            //print(nombre);
            let rutaFinal = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nombre)
            //print(rutaFinal);
            if fileManager.fileExists(atPath: rutaFinal){
                //print("Existe Imagen");
                do {
                    return try Data(contentsOf: URL(fileURLWithPath: rutaFinal));
                } catch let error as NSError {
                    print(error.localizedDescription);
                    return nil;
                }
                //return UIImage(contentsOfFile: rutaFinal as String);
            } else {
                //print("No Image")
                return nil;
            }
        } else {
            //print("Error con el nombre de la imagen");
            return nil;
        }
    }
    
}
