//
//  MetroViewController.swift
//  HW2
//
//  Created by Майя Герасимова on 01.12.2020.
//

import UIKit

class MetroViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var lines = [Line]()
    private let spacing: CGFloat = 5
    private let numberOfItemsPerRow: CGFloat = 2



    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
    }
    
    private func loadData(){
        NetworkService.loadLines{
            (lines, error) in
            if let error = error {
                self.showAlert(title: error.localizedDescription)
            }
            self.lines = lines
            self.collectionView.reloadData()
        }
    }
    
    
    
    private func showAlert(title: String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    private func configure(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSecondVC"{
            guard let secondVC = segue.destination as? StationTableViewController,
            let stations = sender as? [Station]
            else{
                fatalError("Incorrect data passed")
            }
            secondVC.stations = stations
        }
    }
}


extension MetroViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return lines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MetroCell.identifier, for: indexPath) as? MetroCell else {
                    fatalError("Invalid Cell Kind")
                }
        cell.configure(with: lines[indexPath.row])
        
        return cell
    }
}

extension MetroViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let rawWidth = view.bounds.width - spacing * (numberOfItemsPerRow - 1) - 2 * spacing

            let cellWidth = rawWidth / numberOfItemsPerRow

            return CGSize(width: cellWidth, height: 70)

        }
        

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return spacing
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return spacing
        }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

            let stations = lines[indexPath.row].stations
            performSegue(withIdentifier: "ShowSecondVC", sender: stations)
    }

}
