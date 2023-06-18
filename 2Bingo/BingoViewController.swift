import UIKit
//これが残る
class BingoViewController: UIViewController {
    
    
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    var randomValues = [Int]()
    
    var randomNumbers = Array(1...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButton.layer.cornerRadius = 10.0
        
        resetButton.layer.cornerRadius = 10.0
        
        
    }
    
    //ランダムに値を生成する
    func randomGenerater() {
        
        if randomNumbers.isEmpty {
            
            labelView.text = "終了！"
                        
        } else {
            let randomIndex = Int.random(in: 0..<randomNumbers.count)
            
            let randomValue = randomNumbers[randomIndex]
            
            randomNumbers.remove(at: randomIndex)
            
            randomValues.append(randomValue)
            
            print("\(randomValues)を渡しました")
            
            labelView.text = "\(randomValue)"
            
        }
    }
    
    
    @IBAction func tapAction(_ sender: Any) {
        
        if !randomNumbers.isEmpty {
               randomGenerater()
               print("\(randomNumbers.count)")
        } else {
            
            labelView.text = "終了！"
        }
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        print("タップは無効です")
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
            randomValues = []
        
            randomNumbers = Array(1...10)
            
            labelView.text = "最初から！"
        
        print("リセットしました！")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //segueのIDの確認
        if segue.identifier == "checkNum" {
            
            //遷移先のViewContorollerのインスタンス化
            if let checkNumVC = segue.destination as? CheckNumberViewController {
                
                    checkNumVC.checkValue = randomValues.map { String($0) }
                
                }
            }
        }
//
}
