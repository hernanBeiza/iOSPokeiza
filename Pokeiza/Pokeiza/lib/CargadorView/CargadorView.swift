//
//  CargadorView.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/18/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation
import UIKit;

final class CargadorView: UIView {
    
    private var mensajeLabel:UILabel?;
    
    static var sharedInstance = CargadorView()
    
    //public static func sharedInstanceWith(parentView:UIView) -> CargadorView {
    public func mostrarEn(parentView:UIView, mensaje:String) {
        //print(String(describing: CargadorView.self), #function);
        self.configEn(parentView: parentView, mensaje:mensaje);
    }

    private func configEn(parentView:UIView, mensaje:String){
        let tamano:CGFloat = 80;
        let posX = parentView.frame.width/2-tamano/2;
        let posY = parentView.frame.height/2-tamano/2;
        self.layer.cornerRadius = 5;
        self.frame = CGRect.init(x: posX, y: posY, width: tamano, height: tamano);
        self.backgroundColor = UIColor.init(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7);
        //UIActivityIndicadorView
        let spinner = UIActivityIndicatorView();
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge;
        spinner.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2);
        self.addSubview(spinner);
        spinner.startAnimating();
        
        self.mensajeLabel = UILabel();
        self.mensajeLabel?.frame = CGRect.init(x:0,y:60,width:80,height:20);
        self.mensajeLabel?.font = self.mensajeLabel?.font.withSize(UIFont.smallSystemFontSize);
        self.mensajeLabel?.textColor = UIColor.white;
        self.mensajeLabel?.textAlignment = NSTextAlignment.center;
        self.mensajeLabel?.text = mensaje;
        self.addSubview(mensajeLabel!);
        
        parentView.addSubview(self);
    }

    convenience init(parentView:UIView) {
        //print(String(describing: CargadorView.self), #function);
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        //print(String(describing: CargadorView.self), #function);
        super.init(frame: frame);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    public func ocultar() {
        //print(String(describing: CargadorView.self), #function);
        self.removeFromSuperview();
    }
    
    deinit {
        //print(String(describing: CargadorView.self), #function);
    }

}


