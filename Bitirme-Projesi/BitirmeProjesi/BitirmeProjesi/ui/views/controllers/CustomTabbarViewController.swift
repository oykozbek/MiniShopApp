//
//  CustomTabbarViewController.swift
//  BitirmeProjesi
//
//  Created by ÖYKÜ  ÖZBEK on 29.05.2024.
//

import UIKit

class CustomTabbarViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomTabView: UIView?
    @IBOutlet var selectedStateViews: [UIView]!
    
    var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomTabView?.layer.cornerRadius = (bottomTabView?.frame.size.height ?? 0.0) / 2.0
        
        handleSelectedView(current: 0)
        
        let controller = main.instantiateViewController(withIdentifier: String(describing: Anasayfa.self))
        addChild(controller)
        containerView?.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        
    }
    
    @IBAction func tabTapped(_ sender: UIButton) {
        let tag = sender.tag
        handleSelectedView(current: tag)
        
        if tag == 0 {
            let controller = main.instantiateViewController(withIdentifier: String(describing: Anasayfa.self))
            addChild(controller)
            containerView?.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            
        }else if tag == 1 {
            let controller = main.instantiateViewController(withIdentifier: String(describing: FavorilerViewController.self))
            addChild(controller)
            containerView?.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            
        }else if tag == 2 {
            let controller = main.instantiateViewController(withIdentifier: String(describing: ProfilViewController.self))
            addChild(controller)
            containerView?.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            
        }
    }
    
    func handleSelectedView(current state: Int) {
        selectedStateViews.forEach { selectedVİew in
            print(selectedVİew.tag)
            selectedVİew.isHidden = (selectedVİew.tag != state)
        }
    }
}
