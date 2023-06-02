
import UIKit

class BingoViewController: UIViewController {
    
    @IBOutlet weak var labelView: UILabel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            randomNumber = RandomNumber()
    }
    
    //ランダムに値を取り出し削除する構造体
    struct RandomNumber {
        
        var randomNumbers: [Int]
        
        var randomNum: Int
        
        init() {
            randomNumbers = Array(1...75)
            
            randomNum = randomNumbers.remove(at: Int.random(in: 0..<randomNumbers.count))
        }
    }

    var randomNumber: RandomNumber?


    @IBAction func tapAction(_ sender: Any) {

        randomNumber = RandomNumber()  // タップ時に構造体のインスタンスを更新
                
                // ラベルに新しいランダムな値を表示する
                labelView.text = "\(randomNumber?.randomNum ?? 0)"
    }
    
    
    @IBAction func checkButton(_ sender: Any) {
        
        performSegue(withIdentifier: "checkNum", sender: nil)
    }
    
    @IBAction func resetButton(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "checkNum" {
            
            if let checkNumVC = segue.destination as? CheckNumberViewController {
                
                if let randomNumber = randomNumber {
                    
                    checkNumVC.checkValue.append(String(randomNumber.randomNum))
                }
            }
        }
    }

    
//classの底
}
