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
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent("wcg.realm")
    
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
    
/* TODO: Refactor piechart generation functions to standardize a bit now that they are more similar. I would do it right now but I've already spent too much time on this app don't @ me*/
    
    private func updateRaceChart(previousGenerations: Results<GenerationHistory>)
    {
        var dataEntries: [PieChartDataEntry] = []
        
        let allRaces = getRacesFromDB()
        
        for race in allRaces
        {
            var raceCount: Double = 0
            for generation in previousGenerations
            {
                if(generation.race?.race_name == race.race_name)
                {
                    raceCount = raceCount + 1
                }
            }
            if(raceCount > 0)
            {
                dataEntries.append(PieChartDataEntry(value: raceCount, label: race.race_name))
            }
        }
        
        raceChartView.usePercentValuesEnabled = true
        raceChartView.drawSlicesUnderHoleEnabled = false
        raceChartView.drawHoleEnabled = false
        raceChartView.legend.enabled = false
        raceChartView.rotationEnabled = false
        raceChartView.chartDescription?.text = ""
        raceChartView.noDataFont = UIFont(name: "FrizQuadrataStd", size: 12.0)
        raceChartView.noDataTextColor = NSUIColor(cgColor: UIColor.white.cgColor)
        
        if(dataEntries.count > 0)
        {
            let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
            chartDataSet.colors = ChartColorTemplates.pastel()
            chartDataSet.valueFont = UIFont(name: "FrizQuadrataStd", size: 14.0)!
            
            let pieChartData = PieChartData(dataSet: chartDataSet)
            raceChartView.data = pieChartData
        }
    }
    
    private func updateClassChart(previousGenerations: Results<GenerationHistory>)
    {
        var dataEntries: [PieChartDataEntry] = []
        var dataSetColors: [UIColor] = []
        
        let classes = getClassesFromDB()
        
        for wc_class in classes
        {
            var classCount: Double = 0
            for generation in previousGenerations
            {
                if(generation.warcraft_class?.class_name == wc_class.class_name)
                {
                    classCount = classCount + 1
                }
            }
            if(classCount > 0)
            {
                dataSetColors.append(UIColor.init(hex: wc_class.chart_color))
                dataEntries.append(PieChartDataEntry(value: classCount, label: wc_class.class_name))
            }
        }
        
        classChartView.usePercentValuesEnabled = true
        classChartView.drawSlicesUnderHoleEnabled = false
        classChartView.drawHoleEnabled = false
        classChartView.legend.enabled = false
        classChartView.rotationEnabled = false
        classChartView.chartDescription?.text = ""
        classChartView.noDataFont = UIFont(name: "FrizQuadrataStd", size: 12.0)
        classChartView.noDataTextColor = NSUIColor(cgColor: UIColor.white.cgColor)
        
        if(dataEntries.count > 0)
        {
            let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
            chartDataSet.colors = dataSetColors
            chartDataSet.valueFont = UIFont(name: "FrizQuadrataStd", size: 14.0)!
            
            let pieChartData = PieChartData(dataSet: chartDataSet)
            classChartView.data = pieChartData
        }
        
    }
    
    private func updateFactionChart(previousGenerations: Results<GenerationHistory>)
    {
        var dataEntries: [PieChartDataEntry] = []
        var dataSetColors: [UIColor] = []
        
        let factions = getFactionsFromDB()
        
        for fact in factions
        {
            var factionCount: Double = 0
            for generation in previousGenerations
            {
                if(generation.faction?.faction_name == fact.faction_name)
                {
                    factionCount = factionCount + 1
                }
            }
            if(factionCount > 0)
            {
                dataSetColors.append(UIColor.init(hex: fact.chart_color))
                dataEntries.append(PieChartDataEntry(value: factionCount, label: fact.faction_name))
            }
        }
        
        factionChartView.usePercentValuesEnabled = true
        factionChartView.drawSlicesUnderHoleEnabled = false
        factionChartView.drawHoleEnabled = false
        factionChartView.legend.enabled = false
        factionChartView.rotationEnabled = false
        factionChartView.chartDescription?.text = ""
        factionChartView.noDataFont = UIFont(name: "FrizQuadrataStd", size: 12.0)
        factionChartView.noDataTextColor = NSUIColor(cgColor: UIColor.white.cgColor)
        
        if(dataEntries.count > 0)
        {
            let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
            chartDataSet.colors = dataSetColors
            chartDataSet.valueFont = UIFont(name: "FrizQuadrataStd", size: 14.0)!
            
            let pieChartData = PieChartData(dataSet: chartDataSet)
            factionChartView.data = pieChartData
        }
    }
    
/* TODO: Use generics for these realm calls, maybe separate into another class as well */
    
    private func getPreviousGenerationsFromDatabase() -> Results<GenerationHistory>
    {
        var newestSchemaVersion: UInt64 = 24
        do
        {
            newestSchemaVersion = try schemaVersionAtURL(filePath)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        do
        {
            let realm = try Realm(configuration: Realm.Configuration(fileURL: filePath, readOnly: true, schemaVersion: newestSchemaVersion))
            return realm.objects(GenerationHistory.self)
        }
        catch let error as NSError
        {
            fatalError(error.localizedDescription)
        }
    }
    
    private func getFactionsFromDB() -> Results<WarcraftFaction>
    {
        var newestSchemaVersion: UInt64 = 24
        do
        {
            newestSchemaVersion = try schemaVersionAtURL(filePath)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        do
        {
            let realm = try Realm(configuration: Realm.Configuration(fileURL: filePath, readOnly: true, schemaVersion: newestSchemaVersion))
            return realm.objects(WarcraftFaction.self)
        }
        catch let error as NSError
        {
            fatalError(error.localizedDescription)
        }
    }
    
    private func getClassesFromDB() -> Results<WarcraftClass>
    {
        var newestSchemaVersion: UInt64 = 24
        do
        {
            newestSchemaVersion = try schemaVersionAtURL(filePath)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        do
        {
            let realm = try Realm(configuration: Realm.Configuration(fileURL: filePath, readOnly: true, schemaVersion: newestSchemaVersion))
            return realm.objects(WarcraftClass.self)
        }
        catch let error as NSError
        {
            fatalError(error.localizedDescription)
        }
    }
    
    private func getRacesFromDB() -> Results<WarcraftRace>
    {
        var newestSchemaVersion: UInt64 = 24
        do
        {
            newestSchemaVersion = try schemaVersionAtURL(filePath)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        do
        {
            let realm = try Realm(configuration: Realm.Configuration(fileURL: filePath, readOnly: true, schemaVersion: newestSchemaVersion))
            return realm.objects(WarcraftRace.self)
        }
        catch let error as NSError
        {
            fatalError(error.localizedDescription)
        }
    }
}
