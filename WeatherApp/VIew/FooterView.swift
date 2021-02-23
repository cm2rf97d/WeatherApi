//
//  FooterView.swift
//  WeatherApp
//
//  Created by 陳郁勳 on 2021/2/22.
//

import UIKit

class FooterView: UIView
{
    var celsiusLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "C˚"
        label.textColor = .white
        return label
    }()
    
    var fahrenheitLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " F˚"
        label.textColor = .gray
        return label
    }()
    
    var slashLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "/ "
        label.textColor = .white
        return label
    }()
    
    var changeCelsuisAndFahrenheitButton: UIButton =
    {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "放大燈.webp"), for: .normal)
        return button
    }()
    
    lazy var footerStackView: UIStackView =
    {
        let stackView = UIStackView(arrangedSubviews: [celsiusLabel,slashLabel,fahrenheitLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(changeCelsuisAndFahrenheitButton)
        addSubview(footerStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
