//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by 陳郁勳 on 2021/2/23.
//

import UIKit

protocol addWeatherDelegate
{
    func addWeatherDelegate(city: String)
}

class WeatherDetailViewController: UIViewController
{
    
    var addWeatherDelegate: addWeatherDelegate?
    var cityName: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        let test: UILabel =
        {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = cityName
            label.textColor = .white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 40)
            return label
        }()
        view.addSubview(test)
        
        test.widthAnchor.constraint(equalToConstant: ViewController().fullSize.width).isActive = true
        test.heightAnchor.constraint(equalToConstant: ViewController().fullSize.height).isActive = true
        test.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        test.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        setNavigationBarColor()
        setNavigationRightButton()
    }
    
    func setNavigationBarColor()
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    func setNavigationRightButton()
    {
        let button = UIBarButtonItem(title: "加入", style: .plain, target: self, action: #selector(addWeather))
        button.tintColor = .white
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.rightBarButtonItem?.title = "加入"
    }
    
    @objc func addWeather()
    {
        addWeatherDelegate?.addWeatherDelegate(city: cityName)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
