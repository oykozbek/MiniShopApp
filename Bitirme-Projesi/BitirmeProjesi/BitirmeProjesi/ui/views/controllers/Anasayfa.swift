//
//  AnaSayfaViewController.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import UIKit
import Kingfisher


class Anasayfa: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelSelamlama: UILabel!
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    @IBOutlet weak var buttonSepet: UIButton!
    
    var yemeklerListesi = [Yemekler]()
    var viewModel = AnasayfaViewModel()
    var yemekDetayViewModel = YemekDetayViewModel()
    var collectionViewCell = YemeklerHucre()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSepet.layer.cornerRadius = buttonSepet.frame.size.height/2
        buttonSepet.layer.borderWidth = 2
        buttonSepet.layer.borderColor = UIColor.black.cgColor
        buttonSepet.layer.masksToBounds = true
        
        searchBar.delegate = self
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        setCollectionView()
        configureCollectionView()
        setSearchBar()
        setViewModel()

    }
    
    func setCollectionView() {
        yemeklerCollectionView.dataSource = self
        yemeklerCollectionView.delegate = self
    }
    
    func configureCollectionView() {
        let collectionDesign = UICollectionViewFlowLayout()
        collectionDesign.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionDesign.minimumLineSpacing = 10
        collectionDesign.minimumInteritemSpacing = 10
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 40) / 2
        collectionDesign.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.6)
        yemeklerCollectionView.collectionViewLayout = collectionDesign

    }
    
    func setSearchBar(){
        searchBar.delegate = self
    }
    
    func setViewModel(){
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async {
                self.yemeklerCollectionView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yemekleriYukle()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let yemek = sender as? Yemekler {
                let gitVC = segue.destination as! YemekDetay
                gitVC.yemek = yemek
            }
        }
    }
    
    @IBAction func buttonSepetGit(_ sender: Any) {
        performSegue(withIdentifier: "toSepet", sender: nil)
    }
    
}

