//
//  SepetViewModel.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import Foundation
import UIKit
import RxSwift

class SepetViewModel {
    let repo = YemeklerRepository()
    var yemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    var toplamTutar = BehaviorSubject<Int>(value: Int())
    
    init() {
            yemeklerListesi = repo.sepetYemeklerListesi
            toplamTutar = repo.toplamTutar
        }
        
        func getirSepetYemekler(kullanici_adi: String) {
            repo.getirSepetYemekler(kullanici_adi: kullanici_adi)
        }
        
        func silSepetYemek(sepet_yemek_id: Int, kullanici_adi: String) {
            repo.sepettenYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
        }
}
