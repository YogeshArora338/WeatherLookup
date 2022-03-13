//
//  HomeViewController.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 11/03/22.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - UI Components
    @IBOutlet weak var txtCityName: UITextField!
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtCityName.addTarget(self, action: #selector(onTextFieldChanged), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Home"
    }
    
    private func showErrorState() {
        self.txtCityName.layer.borderWidth = 0.5
        self.txtCityName.layer.borderColor = UIColor.red.cgColor
    }
    
    private func hideErrorState() {
        self.txtCityName.layer.borderWidth = 0.0
        self.txtCityName.layer.borderColor = UIColor.clear.cgColor
    }
    
    // MARK: - Actions
    
    @IBAction func lookupAction(_ sender: UIButton) {
        let cityName: String = self.txtCityName.text?.trimmed ?? ""
        
        if cityName.isEmpty {
            self.showErrorState()
        } else {
            self.routeTo(.listing(cityName: cityName))
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    @objc func onTextFieldChanged() {
        let cityName: String = self.txtCityName.text?.trimmed ?? ""
        if cityName.isEmpty {
            self.showErrorState()
        } else {
            self.hideErrorState()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

