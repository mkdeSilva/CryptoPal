//
//  CurrencyCardsTableViewController.swift
//  CryptoBuddy
//
//  Created by Mihindu de Silva on 10/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit


class CurrencyCardsTableViewController: UITableViewController {
    
    
    var viewModels = [CurrencyCardViewModel](){
        didSet{
            tableView.reloadData()
        }
    }
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        CurrencyServiceAPI.shared.getData { (result : Result<CurrencyServiceAPI.PairingData, CurrencyServiceAPI.APIServiceError>) in
            switch (result){
            case .success(let response):
                var thbCurrencies = response.values.filter{$0.primaryCurrency == "THB"}
                thbCurrencies.sort() {$0.secondaryCurrency < $1.secondaryCurrency}
                
                let viewModels = thbCurrencies.compactMap(CurrencyCardViewModel.init)
                
                
                sender.endRefreshing()
                self.viewModels = viewModels
                self.tableView.reloadData()
                
            case .failure(let error):
                print("Error: \(error)")
                sender.endRefreshing()
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.bgColor
        loadCurrencyData()
    }
    
    private func loadCurrencyData()
    {
        CurrencyServiceAPI.shared.getData { (result : Result<CurrencyServiceAPI.PairingData, CurrencyServiceAPI.APIServiceError>) in
            switch (result){
            case .success(let response):
                var thbCurrencies = response.values.filter{$0.primaryCurrency == "THB"}
                thbCurrencies.sort() {$0.secondaryCurrency < $1.secondaryCurrency}
                
                let viewModels = thbCurrencies.compactMap(CurrencyCardViewModel.init)
                self.viewModels = viewModels
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCardCell", for: indexPath) as! CurrencyCardTableViewCell
        
        
        let viewModel = viewModels[indexPath.section]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.navigationController?.pushViewController(vc, animated: true)
        //  vc.configure(with: viewModels[indexPath.section].pairingID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let section = self.tableView.indexPathForSelectedRow?.section
        {
            guard let detailViewController = segue.destination as? CurrencyDetailViewController else {
                return
            }
            
            detailViewController.configure(with: viewModels[section])
        }
    }
}
