//
//  UIImageView.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/19/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation
import UIKit

//https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
extension UIImageView {

    private func getDataFromUrl(url:String, completion: @escaping ((_ data: NSData?) -> Void)) {
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (data, response, error) in
            completion(NSData(data: data!))
            }.resume()
    }
    
    func downloadImage(url:String){
        
        getDataFromUrl(url: url) { data in
            DispatchQueue.main.async {
                //self.contentMode = UIViewContentMode.scaleAspectFill
                self.image = UIImage(data: data! as Data)
            }            
        }
        
    }
    
}
