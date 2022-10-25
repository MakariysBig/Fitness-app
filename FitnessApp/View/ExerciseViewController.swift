import SnapKit
import Then
import UIKit
import SPAlert

final class ExerciseViewController: UIViewController {
    
    //MARK: - Private propertie
    
    private let userDefoults = UserDefaults.standard
    private let relax = Relax(gif: ExerciseURL.relax.getURL, duration: 3)
    private let exerciseOne   = Exercise(gif: ExerciseURL.bicycleStanding.getURL)
    private let exerciseTwo   = Exercise(gif: ExerciseURL.runingKneesUp.getURL)
    private let exerciseThree = Exercise(gif: ExerciseURL.jumping.getURL)
    private let exerciseFour  = Exercise(gif: ExerciseURL.reverseTwist.getURL)
    private let exerciseFive  = Exercise(gif: ExerciseURL.mountaineer.getURL)
    private let gifImage = UIImageView()
    private let startButton = UIButton()
    private let levelDurationByLevel = ["2", "20", "30", "45", "60" ]
    
    private var dateArray = [Date]()
    private var numberOfExercise = 0
    private var level = 1
    private var timer = Timer()
    private var timerLabel = UILabel()
    private var animateImage = UIImageView()
    private var animateRelaxImage = UIImageView()
    private var levelDuration: Int?
    private var duration: Int = 5
    
    private lazy var exercises = [exerciseOne, exerciseTwo, exerciseThree, exerciseFour, exerciseFive]
    private lazy var relaxDuration = relax.duration

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateData()
        setupStartButton()
        setupTimerLabelLayout(duration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
        setupStartButton()
        setupTimerLabelLayout(duration)
    }
    
    //MARK: - Private method
    
    private func setup() {
        view.backgroundColor = .greenCustomColor
        startButton.addTarget(self, action: #selector(startExersize), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .done, target: self, action: #selector(toStartVC))
        navigationItem.rightBarButtonItem?.tintColor = .yellowCustomColor
    }
    
    private func updateData() {
        level = userDefoults.integer(forKey: "userLevel")
        duration = getLevelDuration()
        setupGifImageLayout(numberOfExercise)
        startButton.setTitle("Start Exercise", for: .normal)
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
    
    private func setupGifImageLayout(_ numberOfexercise: Int) {
        view.addSubview(gifImage)
        
        gifImage.translatesAutoresizingMaskIntoConstraints = false
        gifImage.image = UIImage(named: exercises[numberOfexercise].gif + ".gif")
        gifImage.contentMode = .scaleAspectFill
        gifImage.backgroundColor = .clear
        gifImage.clipsToBounds = true
        gifImage.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            gifImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            gifImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            gifImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }
    
    private func setupTimerLabelLayout(_ duration: Int) {
        view.addSubview(timerLabel)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.text = "\(duration)"
        timerLabel.textAlignment = .center
        timerLabel.textColor = .yellowCustomColor
        timerLabel.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            timerLabel.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            timerLabel.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 25),
            timerLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func configureAnimationImage(numberOfexercise: Int) {
        animateImage = UIImageView.fromGif(frame: self.gifImage.frame, resourceName: exercises[numberOfexercise].gif) ??  UIImageView()
        view.addSubview(animateImage)
        animateImage.contentMode = .scaleAspectFill
        animateImage.animationRepeatCount = 1000
        animateImage.animationDuration = 2
        animateImage.layer.cornerRadius = gifImage.layer.cornerRadius
        animateImage.clipsToBounds = true
    }
    
    private func configureRelaxAnimationImage() {
        animateRelaxImage = UIImageView.fromGif(frame: self.gifImage.frame, resourceName: relax.gif) ??  UIImageView()
        view.addSubview(animateRelaxImage)
        animateRelaxImage.contentMode = .scaleAspectFill
        animateRelaxImage.animationRepeatCount = 1000
        animateRelaxImage.animationDuration = 3
        animateRelaxImage.layer.cornerRadius = gifImage.layer.cornerRadius
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
    
    private func setupStartButton() {
        view.addSubview(startButton)
        
        startButton.setTitle("Start Exercise", for: .normal)
        startButton.setTitleColor(.yellowCustomColor, for: .normal)
        startButton.layer.cornerRadius = gifImage.layer.cornerRadius
        startButton.backgroundColor = .blueCustomColor
        startButton.backgroundColor = .lightGreenCustomColor

        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: gifImage.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: gifImage.trailingAnchor),
            startButton.topAnchor.constraint(equalTo: gifImage.bottomAnchor, constant: 25),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        startButton.addTarget(self, action: #selector(startExersize), for: .touchUpInside)
    }
    
    private func nextExercise() {
        startButton.isEnabled = true
        startButton.setTitle("Next exercise", for: .normal)
        startButton.backgroundColor = .lightGreenCustomColor
        let count = exercises.count - 1
        
        if numberOfExercise < count {
            numberOfExercise += 1
            duration = getLevelDuration()
            timerLabel.text = String(duration)
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
            timerLabel.text = String(duration)
        } else {
            timer.invalidate()
            animateImage.stopAnimating()
            animateImage.isHidden = true
            animateRelaxImage.isHidden = false
            startButton.setTitle("Time to relax", for: .normal)
            startButton.isEnabled = false
            startButton.backgroundColor = .greenCustomColor
            if relaxDuration > 0 {
                configureTimer()
                animateRelaxImage.startAnimating()
                relaxDuration -= 1
                timerLabel.text = String(relaxDuration)
            } else {
                timer.invalidate()
                animateRelaxImage.stopAnimating()
                nextExercise()
                if let levelDuration {
                    duration = levelDuration
                }
                relaxDuration = relax.duration
                gifImage.image = UIImage(named: exercises[numberOfExercise].gif + ".gif")
            }
        }
    }
}


