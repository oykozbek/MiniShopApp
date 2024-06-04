//
//  Sepet.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import UIKit
import RxSwift

class Sepet: UIViewController {
    
    @IBOutlet weak var labelGonderimUcreti: UILabel!
    @IBOutlet weak var labelViewToplamFiyat: UILabel!
    @IBOutlet weak var labelViewToplam: UILabel!
    @IBOutlet weak var viewToplam: UIView!
    @IBOutlet weak var viewSepetiOnayla: UIView!
    @IBOutlet weak var sepetYemeklerTableView: UITableView!
    
    let viewModel = SepetViewModel()
    var yemeklerListesi = [SepetYemekler]()
    private var toplamTutar = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewToplam.layer.cornerRadius = viewToplam.frame.size.height / 2
        viewToplam.layer.masksToBounds = true
            
        viewSepetiOnayla.layer.cornerRadius = viewSepetiOnayla.frame.size.height / 2
        viewSepetiOnayla.layer.masksToBounds = true
        
        setTableView()
        setToplamTutar()
        setYemeklerListesi()
        
    }
    
    func setTableView() {
        sepetYemeklerTableView.delegate = self
        sepetYemeklerTableView.dataSource = self
    }
    
    func setYemeklerListesi() {
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async {
                self.sepetYemeklerTableView.reloadData()
            }
        })
    }
    
    func setToplamTutar() {
        _ = viewModel.toplamTutar.subscribe(onNext: { toplam in
            self.toplamTutar = toplam
            DispatchQueue.main.async {
                self.labelViewToplamFiyat.text = "\(String(self.toplamTutar)) ₺"
            }
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       viewModel.getirSepetYemekler(kullanici_adi: "oyku_ozbek")
    }
    
    @IBAction func buttonSepetiOnayla(_ sender: UIButton) {
        let alert = UIAlertController(title: "Satın Alma", message: "Siparişiniz başarıyla tamamlandı.", preferredStyle: .alert)
        let tamamAction = UIAlertAction(title: "Tamam", style: .cancel) { _ in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabbarViewController") as! CustomTabbarViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: true, completion: nil)
        }
        alert.addAction(tamamAction)
        self.present(alert, animated: true)
    }
    


}
