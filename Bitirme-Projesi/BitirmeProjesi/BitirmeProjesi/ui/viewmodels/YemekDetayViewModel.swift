//
//  YemekDetayViewModel.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import Foundation
import UIKit
import RxSwift

class YemekDetayViewModel {
    let repo = YemeklerRepository()
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String, completion: @escaping (Bool) -> Void) {
            repo.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: "oyku_ozbek") { success in
                completion(success)
            }
        }
}
