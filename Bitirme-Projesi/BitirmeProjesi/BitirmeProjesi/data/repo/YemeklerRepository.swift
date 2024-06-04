//
//  YemeklerRepository.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 30.05.2024.
//

import Foundation
import RxSwift
import Alamofire
import UIKit


class YemeklerRepository {
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var sepetYemeklerListesi = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    var toplamTutar = BehaviorSubject<Int>(value: Int())
    
    func yemekleriYukle() {
        let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        AF.request(url, method: .get).response { response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = response.yemekler {
                        self.yemeklerListesi.onNext(liste)
                    }
                }catch{
                    print("Yemek listeleme hatası!")
                }
            }
        }
    }
    
    func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String, completion: @escaping (Bool) -> Void) {
        let url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        let parameters: [String: Any] = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        AF.request(url, method: .post, parameters: parameters).response { response in
            switch response.result {
            case .success(_):
                completion(false)
            case .failure(_):
                completion(true)
            }
        }
    }
    
    func sepettenYemekSil(sepet_yemek_id: Int, kullanici_adi:String) {
        let parametre: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]
        let url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        AF.request(url, method: .post, parameters: parametre).response { response in
            if let data = response.data{
                do{
                    _ = try JSONDecoder().decode(SepetCevap.self, from: data)
                    self.getirSepetYemekler(kullanici_adi: kullanici_adi) { _ , error in
                        if error != nil {
                            self.toplamTutar.onNext(0)
                        }else {
                        }
                            
                    }
                }catch{
                    print("Sepetten yemek silme hatası!")
                }
            }
        }
    }
    
    func getirSepetYemekler(kullanici_adi: String) {
        var toplam = 0
        let parametre: Parameters = ["kullanici_adi": kullanici_adi]
        let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        AF.request(url, method: .post, parameters: parametre).response { response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    if let liste = response.sepet_yemekler {
                        self.sepetYemeklerListesi.onNext(liste)
                        for yemek in liste {
                            toplam += Int(yemek.yemek_siparis_adet)! * Int(yemek.yemek_fiyat)!
                            self.toplamTutar.onNext(toplam)
                      }
                   }
                }catch{
                    print("Sepetten yemek getirirken hata!")
                }
            }
        }
    }
    
    func searchYemekler(aramaKelimesi:String) {
        if aramaKelimesi.isEmpty {
                    yemekleriYukle()
                } else {
                    let url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
                    AF.request(url, method: .get).response { response in
                        if let data = response.data {
                            do {
                                let response = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                                if let liste = response.yemekler {
                                    let searchYemekler = liste.filter { $0.yemek_adi.contains(aramaKelimesi) }
                                    self.yemeklerListesi.onNext(searchYemekler)
                                }
                            } catch {
                                print("Arama yapılırken hata!")
                            }
                        }
                    }
                }
    }
    
    func getirSepetYemekler(kullanici_adi: String, completion: @escaping([SepetYemekler]?, Error?) -> Void) {
        var toplam = 0
        let parametre: Parameters = ["kullanici_adi": kullanici_adi]
        let url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        AF.request(url, method: .post, parameters: parametre).response { response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                    if let liste = response.sepet_yemekler {
                        self.sepetYemeklerListesi.onNext(liste)
                        for yemek in liste {
                            toplam += Int(yemek.yemek_siparis_adet)! * Int(yemek.yemek_fiyat)!
                            self.toplamTutar.onNext(toplam)
                      }
                      completion(liste,nil)
                   }
                }catch{
                    print("Sepetten yemek getirirken hata!")
                    completion(nil, error)
                }
            }
        }
    }


    
}

