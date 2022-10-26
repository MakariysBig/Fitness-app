import SnapKit
import Then
import UIKit
import SPAlert

final class ExerciseViewController: UIViewController {
    
    //MARK: - Private propertie
    
    private var rootView: ExerciseView {
        self.view as! ExerciseView
    }
    
    private let userDefoults = UserDefaults.standard
    private let relax = Relax(gif: ExerciseURL.relax.getURL, duration: 3)
    private let exerciseOne   = Exercise(gif: ExerciseURL.bicycleStanding.getURL)
    private let exerciseTwo   = Exercise(gif: ExerciseURL.runingKneesUp.getURL)
    private let exerciseThree = Exercise(gif: ExerciseURL.jumping.getURL)
    private let exerciseFour  = Exercise(gif: ExerciseURL.reverseTwist.getURL)
    private let exerciseFive  = Exercise(gif: ExerciseURL.mountaineer.getURL)
    private let levelDurationByLevel = ["2", "20", "30", "45", "60" ]
    
    private var dateArray = [Date]()
    private var numberOfExercise = 0
    private var level = 1
    private var timer = Timer()
    private var animateImage = UIImageView()
    private var animateRelaxImage = UIImageView()
    private var levelDuration: Int?
    private var duration: Int = 5
    
    private lazy var exercises = [exerciseOne, exerciseTwo, exerciseThree, exerciseFour, exerciseFive]
    private lazy var relaxDuration = relax.duration

    //MARK: - Lifecycle
    
    override func loadView() {
        self.view = ExerciseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavItem()
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    //MARK: - Private method
    
    private func setup() {
        rootView.startButton.addTarget(self, action: #selector(startExersize), for: .touchUpInside)
        rootView.gifImage.image = UIImage(named: exercises[numberOfExercise].gif + ".gif")
    }
    
    private func setupNavItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(toStartVC))
        navigationItem.rightBarButtonItem?.tintColor = .yellowCustomColor
    }
    
    private func updateData() {
        level = userDefoults.integer(forKey: "userLevel")
        duration = getLevelDuration()
        rootView.timerLabel.text = "\(duration)"
        rootView.startButton.setTitle("Start Exercise", for: .normal)
    }
    
    private func getLevelDuration() -> Int {
        levelDuration = Int(levelDurationByLevel[level - 1]) ?? 0
        
        if let levelDuration = levelDuration {
            return levelDuration
        }
        return 0
    }
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(timerUpdate), userInfo: NSDate(), repeats: true)
    }
    
    private func configureAnimationImage(numberOfexercise: Int) {
        animateImage = UIImageView.fromGif(frame: rootView.gifImage.frame, resourceName: exercises[numberOfexercise].gif) ??  UIImageView()
        view.addSubview(animateImage)
        animateImage.contentMode = .scaleAspectFill
        animateImage.animationRepeatCount = 1000
        animateImage.animationDuration = 2
        animateImage.layer.cornerRadius = rootView.gifImage.layer.cornerRadius
        animateImage.clipsToBounds = true
    }
    
    private func configureRelaxAnimationImage() {
        animateRelaxImage = UIImageView.fromGif(frame: rootView.gifImage.frame, resourceName: relax.gif) ??  UIImageView()
        view.addSubview(animateRelaxImage)
        animateRelaxImage.contentMode = .scaleAspectFill
        animateRelaxImage.animationRepeatCount = 1000
        animateRelaxImage.animationDuration = 3
        animateRelaxImage.layer.cornerRadius = rootView.gifImage.layer.cornerRadius
        animateRelaxImage.clipsToBounds = true
    }
    
    private func addDate() {
        dateArray = userDefoults.value(forKey: "date") as? [Date] ?? []
        
        let date = Date()
        let fullFormatter = DateFormatter()
        
        fullFormatter.dateFormat = "MM/dd/yyy"
        fullFormatter.locale = Locale(identifier: "en")
        
        let formatedDate = fullFormatter.string(from: date)
        var formatedDateFromArray = ""
        
        if let dateFromArray = dateArray.first {
            formatedDateFromArray = fullFormatter.string(from: dateFromArray)
        } else {
            dateArray.insert(date, at: 0)
            userDefoults.set(dateArray, forKey: "date")
            dateArray = userDefoults.value(forKey: "date") as? [Date] ?? []
            
            guard let dateFromArray = dateArray.last else { return }
            
            formatedDateFromArray = fullFormatter.string(from: dateFromArray)
        }
        
        if formatedDate != formatedDateFromArray {
            dateArray.insert(date, at: 0)
            userDefoults.set(dateArray, forKey: "date")
            dateArray = userDefoults.value(forKey: "date") as? [Date] ?? []
        }
    }
    
    private func nextExercise() {
        rootView.startButton.isEnabled = true
        rootView.startButton.setTitle("Next exercise", for: .normal)
        rootView.startButton.backgroundColor = .lightGreenCustomColor
        let count = exercises.count - 1
        
        if numberOfExercise < count {
            numberOfExercise += 1
            duration = getLevelDuration()
            rootView.timerLabel.text = String(duration)
        } else {
            let alert = SPAlertView(title: "Success", message: "You have complited\ndaily exercise", preset: .done)
            alert.duration = 3
            alert.present()
            addDate()
            dismiss(animated: true)
        }
    }
    
    //MARK: - Private action
    
    @objc private func toStartVC() {
        dismiss(animated: true)
    }
    
    @objc private func startExersize() {
        duration = getLevelDuration()
        configureAnimationImage(numberOfexercise: numberOfExercise)
        configureRelaxAnimationImage()
        animateRelaxImage.isHidden = true
        animateImage.isHidden = false
        configureTimer()
        animateImage.startAnimating()
    }
    
    @objc private func timerUpdate() {
        if duration > 0 {
            duration -= 1
            rootView.timerLabel.text = String(duration)
        } else {
            timer.invalidate()
            animateImage.stopAnimating()
            animateImage.isHidden = true
            animateRelaxImage.isHidden = false
            rootView.startButton.setTitle("Time to relax", for: .normal)
            rootView.startButton.isEnabled = false
            rootView.startButton.backgroundColor = .greenCustomColor
            
            if relaxDuration > 0 {
                configureTimer()
                animateRelaxImage.startAnimating()
                relaxDuration -= 1
                rootView.timerLabel.text = String(relaxDuration)
            } else {
                timer.invalidate()
                animateRelaxImage.stopAnimating()
                nextExercise()
                
                if let levelDuration {
                    duration = levelDuration
                }
                
                relaxDuration = relax.duration
                rootView.gifImage.image = UIImage(named: exercises[numberOfExercise].gif + ".gif")
            }
        }
    }
}


