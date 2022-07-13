//
//  SplashViewController.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 08.07.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let circularProgress = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        circularProgress.center = self.view.center
        self.view.addSubview(circularProgress)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.circularProgress.stopAnimate()
            let vc = MainViewController()
            vc.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
