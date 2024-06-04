//
//  SepetYemeklerHucre.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 30.05.2024.
//

import UIKit

class SepetYemeklerHucre: UITableViewCell {
    @IBOutlet weak var hucreArkaplan: UIView!
    @IBOutlet weak var imageViewSepetYemek: UIImageView!
    @IBOutlet weak var labelSepetYemekToplamFiyat: UILabel!
    @IBOutlet weak var labelSepetYemekAdet: UILabel!
    @IBOutlet weak var labelSepetYemekFiyat: UILabel!
    @IBOutlet weak var labelSepetYemekAd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
