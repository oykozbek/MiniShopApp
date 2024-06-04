//
//  YemekDetay.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import UIKit
import Kingfisher

class YemekDetay: UIViewController {
    @IBOutlet weak var labelAdet: UILabel!
    @IBOutlet weak var labelYemekAdi: UILabel!
    @IBOutlet weak var yemekArkaplan: UIView!
    @IBOutlet weak var imageViewYemek: UIImageView!
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var labelFiyat: UILabel!
    @IBOutlet weak var labelSure: UILabel!
    
    var yemek: Yemekler?
    var adet = 1
    let viewModel = YemekDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = UIBezierPath(roundedRect: yemekArkaplan.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: yemekArkaplan.frame.width / 2, height: yemekArkaplan.frame.height / 2))
        
        let mask = CAShapeLayer()
                mask.path = path.cgPath
                yemekArkaplan.layer.mask = mask
        
        viewBar.layer.cornerRadius = (viewBar.frame.size.height) / 2
        labelFiyat.layer.cornerRadius = labelFiyat.frame.size.height / 2
        labelFiyat.layer.masksToBounds = true
        
        setYemekAd()
        setTutarVeAdet()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

           let cornerRadius = labelSure.frame.height / 2

           let pathForLabelSure = UIBezierPath(roundedRect: labelSure.bounds, cornerRadius: cornerRadius)
           
           let maskForLabelSure = CAShapeLayer()
           maskForLabelSure.path = pathForLabelSure.cgPath
           labelSure.layer.mask = maskForLabelSure
    }
    
    func setYemekAd() {
        if let y = yemek {
            labelYemekAdi.text = y.yemek_adi
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(y.yemek_resim_adi)") {
                imageViewYemek.kf.setImage(with: url)
            }
        }
    }
    
    func setTutarVeAdet() {
        labelAdet.text = String(adet)
        labelFiyat.text = "\(String(adet * Int(yemek!.yemek_fiyat)!)) ₺"
    }
    
    @IBAction func buttonArttir(_ sender: Any) {
        adet += 1
        setTutarVeAdet()
    }
    
    
    @IBAction func buttonAzalt(_ sender: Any) {
        if adet > 1 {
           adet -= 1
           setTutarVeAdet()
        }
    }
    
    @IBAction func buttonSepeteEkle(_ sender: UIButton) {
        viewModel.sepeteEkle(yemek_adi: yemek!.yemek_adi, yemek_resim_adi: yemek!.yemek_resim_adi, yemek_fiyat: Int(yemek!.yemek_fiyat) ?? 0, yemek_siparis_adet: adet, kullanici_adi: "oyku_ozbek") { _ in
            let alert = UIAlertController(title: "Sepet İşlemi", message: "Ürün başarıyla sepete eklendi.", preferredStyle: .alert)
            let tamamAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(tamamAction)
            self.present(alert, animated: true)
        }
    }
    
    

}
