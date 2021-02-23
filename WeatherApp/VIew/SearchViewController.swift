//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by 陳郁勳 on 2021/2/19.
//

import UIKit

protocol addWeatherInfo
{
    func addWeatherInfo(city: String)
}

class SearchViewController: UIViewController
{
    let backgroundColor = UIColor(red: CGFloat(30.2/255), green: CGFloat(30.2/255), blue: CGFloat(30.2/255), alpha: 1)
    var addWeatherInfo: addWeatherInfo?
    var searchTableView: UITableView!
    var searchController: UISearchController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "輸入程式、郵遞區號或機場位置"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = backgroundColor

        searchTableView = createTableView()
        searchController = createSearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(searchTableView)
        
        autoLayout()
        
    }
    
    func createTableView() -> UITableView
    {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        return tableView
    }
    
    
    func createSearchController() -> UISearchController
    {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.searchBarStyle = .prominent
        search.searchBar.sizeToFit()
        search.searchBar.tintColor = .green
        return search
    }
    
    func autoLayout()
    {
        searchTableView.widthAnchor.constraint(equalToConstant: ViewController().fullSize.width).isActive = true
        searchTableView.heightAnchor.constraint(equalToConstant: ViewController().fullSize.height).isActive = true
        searchTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "United States"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let nav = UINavigationController(rootViewController: WeatherDetailViewController())
        guard let addWeatherNav = nav.viewControllers.first as? WeatherDetailViewController else {return}
        addWeatherNav.addWeatherDelegate = self
        addWeatherNav.cityName = "United States"
        present(nav, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
}

extension SearchViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let searchText = searchController.searchBar.text else { return }
    }
}

extension SearchViewController: addWeatherDelegate
{
    func addWeatherDelegate(city: String)
    {
        addWeatherInfo?.addWeatherInfo(city: city)
    }
}
