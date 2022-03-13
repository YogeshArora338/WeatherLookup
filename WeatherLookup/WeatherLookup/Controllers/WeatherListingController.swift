//
//  WeatherListingController.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 11/03/22.
//

import UIKit

final class WeatherListingController: BaseViewController {
    
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let apiManager = APIManager()
    
    private var dataModel: WeatherDataModel? {
        didSet {
            self.dataModelDidUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startActivity()
        self.apiManager.getWeather(cityName: self.cityName) { dataModel in
            
            DispatchQueue.main.async { [weak self] in
                self?.stopActivity()
                if let data = dataModel {
                    self?.dataModel = data
                } else {
                    self?.showError()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Weather List"
    }
    
    // MARK: - Private Functions
    private func dataModelDidUpdate() {
        guard let _ = self.dataModel else {
            return
        }
        
        self.tableView.reloadData()
    }
    
    private func startActivity() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    private func stopActivity() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "Error", message: "No weather data for \(self.cityName)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherListingController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?.weather.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! CustomWeatherCell
        
        if let dataModel = self.dataModel {
            cell.lblName.text = dataModel.weather[indexPath.row].main
            cell.lblTemp.text = "\(dataModel.main.temp)"
        }
        
        return cell
    }
}

extension WeatherListingController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataModel = self.dataModel else {
            return
        }
        
        self.routeTo(.detail(itemData: dataModel.mapToItemData(indexPath.row), cityName: self.cityName))
    }
}
