extends Node


enum LetterState {
	NOT_CHECKED,
	NOT_IN_WORD,
	WRONG_PLACE,
	CORRECT
}

const NUMBER_OF_ATTEMPTS = 2
const NUMBER_OF_LETTERS = 5

enum ColorGuesses {
	NOT_CHECKED = 1,
	NOT_IN_WORD = 2,
	WRONG_PLACE = 3,
	CORRECT = 4
}
