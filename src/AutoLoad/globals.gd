extends Node

enum LetterState {
	NOT_CHECKED,
	NOT_IN_WORD,
	WRONG_PLACE,
	CORRECT
}

const LetterColor := {
	NOT_CHECKED = preload("res://Assets/ButtonTextures/Empty.png"),
	NOT_IN_WORD = preload("res://Assets/ButtonTextures/NotInWord.png"),
	WRONG_PLACE = preload("res://Assets/ButtonTextures/WrongPlace.png"),
	CORRECT = preload("res://Assets/ButtonTextures/Correct.png")
}

const KeyboardColor := {
	
}

const NUMBER_OF_ATTEMPTS = 7
const NUMBER_OF_LETTERS = 2
