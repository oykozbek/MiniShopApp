//
//  AnasayfaViewModel.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import Foundation
import RxSwift
import UIKit

class AnasayfaViewModel {
        let repo = YemeklerRepository()
        
        var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
        private var siparisMiktari = BehaviorSubject<Int>(value: 1)
        private var sepetYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
        
        
        
        init() {
            yemeklerListesi = repo.yemeklerListesi
        }
        
        func yemekleriYukle() { 
            repo.yemekleriYukle()
        }
        
        func searchYemekler(aramaKelimesi: String) { 
            repo.searchYemekler(aramaKelimesi: aramaKelimesi)
        }
    
        func guncelleYemek(){
           repo.yemekleriYukle()
       }
    
}
