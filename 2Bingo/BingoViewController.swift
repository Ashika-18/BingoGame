import UIKit

class BingoViewController: UIViewController {
    
    
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    var currentIndex = 0
    
    var timer: Timer?

    var slideShowActive = false

    var shouldGenerateValues = true

    var randomValues = [Int]()
    
    var randomNumbers = Array(1...75)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkButton.layer.cornerRadius = 10.0
        
        resetButton.layer.cornerRadius = 10.0
    }
    
    //start
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateSlide), userInfo: nil, repeats: true)
        randomGenerater() // 最初のタイマー開始時に値を表示
    }
    
    //stop
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        slideShowActive = false // タイマー停止時にスライドショーを無効化
    }

    
    func resetFlag() {
        shouldGenerateValues = true
    }

    //ランダムに値を生成する
    func randomGenerater() {
        
        if !shouldGenerateValues {
                return
            }
        
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
        
        if shouldGenerateValues && !randomNumbers.isEmpty {
            
                randomGenerater()
            
                print("残り\(randomNumbers.count)です!")
            
            } else {
                labelView.text = "終了！"
                
                shouldGenerateValues = false
            }
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        print("タップは無効です")
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        
            randomValues = []
        
            randomNumbers = Array(1...75)
        
            resetFlag()
        
            labelView.text = "最初から！"
        
        print("リセットしました！")
        
    }
    
    @objc func updateSlide() {
        currentIndex += 1
        if currentIndex >= randomNumbers.count {
            stopTimer()
            labelView.text = "終了！"
            shouldGenerateValues = false
        } else {
            let currentValue = randomNumbers[currentIndex]
            labelView.text = "\(currentValue)"
        }
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
