//
//  Extensions.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import Foundation
import UIKit

extension Anasayfa: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemeklerHucre", for: indexPath) as! YemeklerHucre
        let yemek = yemeklerListesi[indexPath.row]
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)") {
            cell.imageViewYemek.kf.setImage(with: url)
        }
        cell.labelAd.text = yemek.yemek_adi
        cell.labelFiyat.text = "\(yemek.yemek_fiyat) ₺"
        cell.addButton = {[unowned self] in
            let chosenYemek = yemeklerListesi[indexPath.row]
            yemekDetayViewModel.sepeteEkle(yemek_adi: chosenYemek.yemek_adi, yemek_resim_adi: chosenYemek.yemek_resim_adi, yemek_fiyat: Int(chosenYemek.yemek_fiyat)!, yemek_siparis_adet: 1, kullanici_adi: "oyku_ozbek") { _ in
                let alert = UIAlertController(title: "Sepet", message: "Ürün başarıyla sepete eklendi.", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Tamam", style: .cancel)
                alert.addAction(okeyAction)
                self.present(alert, animated: true)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let yemek = yemeklerListesi[indexPath.row]
            performSegue(withIdentifier: "toDetay", sender: yemek)
            collectionView.deselectItem(at: indexPath, animated: true)
        }
}

extension Anasayfa: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchYemekler(aramaKelimesi: searchText)
    }
}


extension Sepet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        yemeklerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sepetYemeklerHucre", for: indexPath) as! SepetYemeklerHucre
            let yemek = yemeklerListesi[indexPath.row]
            if let adetFiyat = Int(yemek.yemek_fiyat), let adetSiparis = Int(yemek.yemek_siparis_adet) {
                cell.labelSepetYemekToplamFiyat.text = "\(String(adetFiyat * adetSiparis)) ₺"
            }
            cell.labelSepetYemekAdet.text = "\(yemek.yemek_siparis_adet) adet"
            cell.labelSepetYemekAd.text = yemek.yemek_adi
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi)") {
                cell.imageViewSepetYemek.kf.setImage(with: url)
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let yemek = self.yemeklerListesi[indexPath.row]
                self.viewModel.silSepetYemek(sepet_yemek_id: Int(yemek.sepet_yemek_id)!, kullanici_adi: yemek.kullanici_adi)
                self.yemeklerListesi.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                let alert = UIAlertController(title: "Silme İşlemi", message: "Ürün başarılı bir şekilde sepetten silindi.", preferredStyle: .alert)
                let okeyAction = UIAlertAction(title: "Tamam", style: .cancel)
                alert.addAction(okeyAction)
                self.present(alert, animated: true)
            }
        }
}





