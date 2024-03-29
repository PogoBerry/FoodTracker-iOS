//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Ryan Wheeler on 7/6/19.
//  Copyright © 2019 Ryan Wheeler. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView
    {
        //MARK: Properties
        private var ratingButtons = [UIButton]()
    
        var rating = 0
            {
                didSet
                    {
                       updateButtonSelectionStates()
                        
                    } // didSet
            
            } // rating
    
        @IBInspectable var starSize: CGSize = CGSize (width: 44.0, height: 44.0)
            {
                didSet
                    {
                        setUpButtons()
                
                    } // didSet
        
            } // starSize
    
        @IBInspectable var starCount: Int = 5
            {
                didSet
                    {
                        setUpButtons()
            
                    } // didSet
        
            } // starCount
    
        // an initializer is a method that creates an instance of a class for use
    
        //MARK: Initialization
        override init (frame: CGRect)
            {
                super.init (frame : frame)
                setUpButtons()
            
            } // programmatically initializes the view
    
        required init(coder: NSCoder)
            {
                super.init (coder : coder)
                setUpButtons()
                
            } // loads the view from the storyboard
    
        //MARK: Button Action
        @objc func ratingButtonTapped(button: UIButton)
            {
                guard let index = ratingButtons.firstIndex (of: button) else
                    {
                        fatalError("The button, \(button), is not in the ratingButtons array : \(ratingButtons) ")
                        
                    } // index
                
                // Calculate the rating of the selected button
                let selectedRating = index + 1
                
                if selectedRating == rating
                    {
                        // if the selected star represents the current rating, reset the rating to 0
                        rating = 0
                        
                    } // if
                else
                    {
                        // Otherwise set the rating to the selected star
                        rating = selectedRating
                        
                    } // else
            
            } // ratingButtonTapped
    
        //MARK: Private Methods
        private func setUpButtons()
            {
                // clear any existing buttons
                for button in ratingButtons
                    {
                        removeArrangedSubview(button)
                        button.removeFromSuperview()
                        
                    } // for
                
                ratingButtons.removeAll()
                
                // Load Button Images
                
                let bundle = Bundle (for: type (of: self))
                
                let filledStar = UIImage (named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
                
                let emptyStar  = UIImage (named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
                
                let highlightedStar = UIImage (named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
                
                for index in 0 ..< starCount
                    {
                        let button = UIButton()
                        
                        // Set the button images
                        button.setImage (emptyStar, for: .normal)
                        button.setImage (filledStar, for: .selected)
                        button.setImage (highlightedStar, for: .highlighted)
                        button.setImage (highlightedStar, for: [.highlighted, .selected])
                        
                        // Add constraints
                        button.translatesAutoresizingMaskIntoConstraints = false
                        button.heightAnchor.constraint(equalToConstant:
                            starSize.height).isActive = true
                        button.widthAnchor.constraint(equalToConstant:
                            starSize.width).isActive = true
                        
                        // Set the accessiblitiy label
                        button.accessibilityLabel = "Set \(index + 1) star rating"
                        
                        // Setup the button action
                        button.addTarget(self, action:
                            #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
                        
                        // Add the button to the stack
                        addArrangedSubview(button)
                        
                        // Add the new button to the rating button array
                        ratingButtons.append (button)
                        
                    } // for _ in
                
                updateButtonSelectionStates()
            
            } // setUpButtons
    
        private func updateButtonSelectionStates ()
            {
                for (index, button) in ratingButtons.enumerated()
                    {
                        // If the index of a button is less than the rating, that button should be selected
                        button.isSelected = index < rating
                        
                        // Set the hint string for the currently selected star
                        let hintString: String?
                        
                        if rating == index + 1
                            {
                                hintString = "Tap to reset the rating to zero."
                                
                            } // if
                        
                        else
                            {
                                hintString = nil
                                
                            } // else
                        
                        // Calculate the value string
                        let valueString: String
                        switch (rating)
                            {
                                case 0:
                                    valueString = "No rating set."
                                case 1:
                                    valueString = "1 star set."
                                default:
                                    valueString = "\(rating) stars set."
                            
                            } // switch
                        
                        button.accessibilityHint  = hintString
                        button.accessibilityValue = valueString
                    } // for
                
            } // updateButtonSelectionStates

    } // class RatingControl
