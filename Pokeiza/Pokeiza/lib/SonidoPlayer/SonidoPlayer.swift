//
//  SonidoPlayer.swift
//  Pokeiza
//
//  Created by Hernán Beiza on 12/19/17.
//  Copyright © 2017 Hiperactivo. All rights reserved.
//

import Foundation

import AVFoundation

final class SonidoPlayer {

    static var sharedInstance = SonidoPlayer()

    var player: AVAudioPlayer?

    private func playSound(sonido:String) {
        guard let url = Bundle.main.url(forResource: sonido, withExtension: "wav") else { return }
    
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        
            // The following line is required for the player to work on iOS 11. Change the file type accordingly
            //player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
            // iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            
            guard let player = player else { return }
        
            player.play()
        
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func reproducirSeleccionado(){
        self.playSound(sonido: Constantes.SonidoSELECTED);
    }
    
    func reproducirCargaOK(){
        self.playSound(sonido: Constantes.SonidoOK);
        
    }
    
    func reproducirCargarError(){
        self.playSound(sonido: Constantes.SonidoERROR);
        
    }

}
