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
import RealmSwift

class InfoViewController: UIViewController
{
    @IBOutlet weak var btnCloseInfo: UIButton!
    @IBOutlet var legalButton: UIButton!
    @IBOutlet var imgWcgLogo: SpringImageView!
    @IBOutlet var imgWcgLogoText: SpringImageView!
    @IBOutlet var legalText: SpringTextView!
    @IBOutlet var raceChartView: PieChartView!
    @IBOutlet var factionChartView: PieChartView!
    @IBOutlet var classChartView: PieChartView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let generationHistory = getPreviousGenerationsFromDatabase()
        updateRaceChart(previousGenerations: generationHistory)
        updateClassChart(previousGenerations: generationHistory)
        updateFactionChart(previousGenerations: generationHistory)
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
    
    private func updateRaceChart(previousGenerations: Results<GenerationHistory>)
    {
        raceChartView.usePercentValuesEnabled = true
        raceChartView.drawSlicesUnderHoleEnabled = false
        raceChartView.drawHoleEnabled = false
        raceChartView.legend.enabled = false
        raceChartView.rotationEnabled = false
        raceChartView.chartDescription?.text = ""
        raceChartView.noDataFont = UIFont(name: "FrizQuadrataStd", size: 12.0)
        raceChartView.noDataTextColor = NSUIColor(cgColor: UIColor.white.cgColor)
        
        
        
        var dataEntries: [PieChartDataEntry] = []
        dataEntries.append(PieChartDataEntry(value: 2.0, label: "Warrior"))
        dataEntries.append(PieChartDataEntry(value: 3.0, label: "Shaman"))
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        chartDataSet.colors = [UIColor.brown, UIColor.blue]
        chartDataSet.valueFont = UIFont(name: "FrizQuadrataStd", size: 14.0)!
        
        let pieChartData = PieChartData(dataSet: chartDataSet)
        raceChartView.data = pieChartData
        
    }
    
    private func updateClassChart(previousGenerations: Results<GenerationHistory>)
    {
        classChartView.usePercentValuesEnabled = true
        classChartView.drawSlicesUnderHoleEnabled = false
        classChartView.drawHoleEnabled = false
        classChartView.legend.enabled = false
        classChartView.rotationEnabled = false
        classChartView.chartDescription?.text = ""
        classChartView.noDataFont = UIFont(name: "FrizQuadrataStd", size: 12.0)
        classChartView.noDataTextColor = NSUIColor(cgColor: UIColor.white.cgColor)
        
    }
    
    private func updateFactionChart(previousGenerations: Results<GenerationHistory>)
    {
        factionChartView.usePercentValuesEnabled = true
        factionChartView.drawSlicesUnderHoleEnabled = false
        factionChartView.drawHoleEnabled = false
        factionChartView.legend.enabled = false
        factionChartView.rotationEnabled = false
        factionChartView.chartDescription?.text = ""
        factionChartView.noDataFont = UIFont(name: "FrizQuadrataStd", size: 12.0)
        factionChartView.noDataTextColor = NSUIColor(cgColor: UIColor.white.cgColor)
        
    }
    
    private func getPreviousGenerationsFromDatabase() -> Results<GenerationHistory>
    {
        var newestSchemaVersion: UInt64 = 1
        do
        {
            newestSchemaVersion = try schemaVersionAtURL(URL(string: Bundle.main.path(forResource: "wcg", ofType: "realm")!)!)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        do
        {
            let realm = try Realm(configuration: Realm.Configuration(fileURL: URL(string: Bundle.main.path(forResource: "wcg", ofType: "realm")!), readOnly: true, schemaVersion: newestSchemaVersion))
            return realm.objects(GenerationHistory.self)
        }
        catch let error as NSError
        {
            fatalError(error.localizedDescription)
        }
    }
}
