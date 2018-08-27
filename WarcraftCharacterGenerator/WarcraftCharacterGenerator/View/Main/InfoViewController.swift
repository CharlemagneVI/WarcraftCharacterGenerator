//
//  InfoViewController.swift
//  WarcraftCharacterGenerator
//
//  Created by Chad Fager on 8/22/18.
//  Copyright © 2018 Norfare. All rights reserved.
//

import UIKit
import Spring
import Charts
import ChartsRealm

class InfoViewController: UIViewController
{
    @IBOutlet weak var btnCloseInfo: UIButton!
    @IBOutlet var legalButton: UIButton!
    @IBOutlet var imgWcgLogo: SpringImageView!
    @IBOutlet var imgWcgLogoText: SpringImageView!
    @IBOutlet var legalText: SpringTextView!
    @IBOutlet var raceChartView: PieChartView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateRaceChart()
        updateClassChart()
    }
    
    //Override the status bar to white.
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func CloseInfo(_ sender: Any)
    {
        self.dismiss(animated: true)
    }
    
    @IBAction func showLegal(_ sender: Any)
    {
        print(legalText.isHidden)
        if(legalText.isHidden)
        {
            legalText.animation = "fadeIn"
            legalText.duration = 0.8
            legalText.isHidden = false
            
            imgWcgLogo.animation = "fadeOut"
            imgWcgLogo.duration = 0.8
            imgWcgLogo.autohide = true
            
            imgWcgLogoText.animation = "fadeOut"
            imgWcgLogoText.duration = 0.8
            imgWcgLogoText.autohide = true
            
            imgWcgLogo.animate()
            imgWcgLogoText.animate()
            legalText.animate()
            legalButton.setTitle("Hide Legal", for: .normal)
        }
        else
        {
            legalText.animation = "fadeOut"
            legalText.duration = 0.8
            legalText.autohide = true
            
            imgWcgLogo.animation = "fadeIn"
            imgWcgLogo.duration = 0.8
            imgWcgLogo.isHidden = false
            
            imgWcgLogoText.animation = "fadeIn"
            imgWcgLogoText.duration = 0.8
            imgWcgLogoText.isHidden = false
            
            legalText.animate()
            imgWcgLogo.animate()
            imgWcgLogoText.animate()
            legalButton.setTitle("Legal", for: .normal)
            legalText.isHidden = true
        }
    }
    
    private func updateRaceChart()
    {
        var dataEntries: [PieChartDataEntry] = []
        dataEntries.append(PieChartDataEntry(value: 2.0, label: "Warrior"))
        dataEntries.append(PieChartDataEntry(value: 3.0, label: "Shaman"))
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        chartDataSet.colors = [UIColor.brown, UIColor.blue]
        
        let pieChartData = PieChartData(dataSet: chartDataSet)
        raceChartView.data = pieChartData
        
    }
    
    private func updateClassChart()
    {
        
    }
}
