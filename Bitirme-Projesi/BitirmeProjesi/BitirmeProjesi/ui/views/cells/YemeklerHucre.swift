//
//  YemeklerHucre.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 30.05.2024.
//

import UIKit


class YemeklerHucre: UICollectionViewCell {
    
    @IBOutlet weak var buttonFavori: UIButton!
    @IBOutlet weak var imageViewYemek: UIImageView!
    @IBOutlet weak var labelFiyat: UILabel!
    @IBOutlet weak var labelAciklama: UILabel!
    @IBOutlet weak var labelAd: UILabel!
    @IBOutlet weak var ekleButton: UIButton!
    
    var addButton: (() -> ())?
    
    @IBAction func buttonEkle(_ sender: Any) {
        addButton?()
    }
    
   
    
}
