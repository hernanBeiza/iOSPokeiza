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
    
    static var sharedInstance = CargadorView()
    
    //public static func sharedInstanceWith(parentView:UIView) -> CargadorView {
    public func mostrarEn(parentView:UIView) {
        print(String(describing: CargadorView.self), #function);
        self.configEn(parentView: parentView);
    }

    private func configEn(parentView:UIView){
        let posX = parentView.frame.width/2-25;
        let posY = parentView.frame.height/2-25;
        self.layer.cornerRadius = 5;
        self.frame = CGRect.init(x: posX, y: posY, width: 44, height: 44);
        self.backgroundColor = UIColor.init(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.6);
        //UIActivityIndicadorView
        let spinner = UIActivityIndicatorView();
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge;
        self.addSubview(spinner);
        spinner.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44);
        spinner.startAnimating();
        parentView.addSubview(self);
    }
    
    convenience init(parentView:UIView) {
        print(String(describing: CargadorView.self), #function);
        self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
        print(String(describing: CargadorView.self), #function);
        super.init(frame: frame);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    public func ocultar() {
        print(String(describing: CargadorView.self), #function);
        self.removeFromSuperview();
    }
    
    deinit {
        print(String(describing: CargadorView.self), #function);
    }

}


