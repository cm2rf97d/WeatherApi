//
//  ViewController.swift
//  WeatherApp
//
//  Created by 陳郁勳 on 2021/2/19.
//

import UIKit

class ViewController: UIViewController
{

    let fullSize = UIScreen.main.bounds.size
    var weatherTableView: UITableView!
    var footerView = FooterView()
    var weatherData: [WeatherInfo] = []
    {
        didSet
        {
            print(weatherData[0])
            weatherTableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        view.backgroundColor = .black
        setGradientLayer()
    
        weatherTableView = createTableView()
        
        view.addSubview(weatherTableView)
        autoLayout()
        setFooterAction()
    }

    func setFooterAction()
    {
        let changeTempColor = UITapGestureRecognizer(target: self, action: #selector(singleTapAction))
        footerView.footerStackView.addGestureRecognizer(changeTempColor)
        footerView.changeCelsuisAndFahrenheitButton.addTarget(self, action: #selector(searchWeather), for: .touchUpInside)
    }
    
    func createTableView() -> UITableView
    {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "WeatherHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherHomeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
//        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }
    
    @objc func searchWeather()
    {
        let nav = UINavigationController(rootViewController: SearchViewController())
        guard let firstWeatherNav = nav.viewControllers.first as? SearchViewController else {return}
        firstWeatherNav.addWeatherInfo = self
        present(nav, animated: true, completion: nil)
    }

    @objc func singleTapAction()
    {
        if footerView.celsiusLabel.textColor == UIColor.gray
        {
            footerView.celsiusLabel.textColor = .white
            footerView.fahrenheitLabel.textColor = .gray
        }
        else
        {
            footerView.celsiusLabel.textColor = .gray
            footerView.fahrenheitLabel.textColor = .white
        }
        weatherTableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setLabelInfomation(timeLabel: UILabel, locationLabel: UILabel, temperatureLabel: UILabel,indexPath: Int, cell: UITableViewCell, cellIndexPath: Int)
    {
        if weatherData.isEmpty == false
        {
            timeLabel.text = weatherData[cellIndexPath].base
            locationLabel.text = "456"
            temperatureLabel.text = "789"
            
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            timeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            timeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            timeLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            timeLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            locationLabel.translatesAutoresizingMaskIntoConstraints = false
            locationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            locationLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            locationLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: 50).isActive = true
            locationLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
            temperatureLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            temperatureLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            temperatureLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor, constant: 100).isActive = true
            temperatureLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        }
    }
    
    func getWeather(city: String)
    {
        let address = "http://api.openweathermap.org/data/2.5/weather?q="
        let completeAddress = address + city + "&appid=a9bac302871b59602c6968426069a095"
        
        guard let urlString = completeAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        print(urlString)
        
        if let url = URL(string: urlString)
        {
            print(url)
            URLSession.shared.dataTask(with: url){ (data, response, error) in
                
                if let error = error
                {
                    print("Error: \(error.localizedDescription)")
                }
                
                else if let response = response as? HTTPURLResponse, let data = data
                {
                    print("Status code: \(response.statusCode)")
                    let decoder = JSONDecoder()
                    
                    if let weatherData = try? decoder.decode(WeatherInfo?.self, from: data)
                    {
                        print(weatherData)
                        DispatchQueue.main.async
                        {
                            self.weatherData.append(weatherData)
                        }
                    }
                }
            }.resume()
        }
        else
        {
            print("url is Invalid")
        }
    }

    func setGradientLayer()
    {
        let color1 = UIColor(red: CGFloat(0.0/255), green: CGFloat(62.0/255), blue: CGFloat(62.0/255), alpha: 1).cgColor
        let color2 = UIColor(red: CGFloat(202.0/255), green: CGFloat(255.0/255), blue: CGFloat(255.0/255), alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [color1, color2]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func autoLayout()
    {
        weatherTableView.widthAnchor.constraint(equalToConstant: fullSize.width).isActive = true
        weatherTableView.heightAnchor.constraint(equalToConstant: fullSize.height).isActive = true
        weatherTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        footerView.changeCelsuisAndFahrenheitButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        footerView.changeCelsuisAndFahrenheitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        footerView.changeCelsuisAndFahrenheitButton.rightAnchor.constraint(equalTo: footerView.rightAnchor).isActive = true
        footerView.changeCelsuisAndFahrenheitButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        footerView.footerStackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        footerView.footerStackView.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant: 20).isActive = true
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherHomeTableViewCell", for: indexPath) as? WeatherHomeTableViewCell else { return UITableViewCell()}
        
        setLabelInfomation(timeLabel: cell.timeLabel, locationLabel: cell.locationLabel, temperatureLabel: cell.temperatureLabel, indexPath: indexPath.row, cell: cell, cellIndexPath: indexPath.row)
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return 200
        }
        else
        {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 70
    }
}

extension ViewController: addWeatherInfo
{
    func addWeatherInfo(city: String)
    {
        print(city)
        getWeather(city: city)
    }
    
    
}
