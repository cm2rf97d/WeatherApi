//
//  WeatherHomeTableViewCell.swift
//  WeatherApp
//
//  Created by 陳郁勳 on 2021/2/19.
//

import UIKit

class WeatherHomeTableViewCell: UITableViewCell
{
    var timeLabel = UILabel()
    var locationLabel = UILabel()
    var temperatureLabel = UILabel()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        addSubview(timeLabel)
        addSubview(locationLabel)
        addSubview(temperatureLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
