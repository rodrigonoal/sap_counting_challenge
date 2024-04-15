const data = 'ABAP4BTP is amazing ';

class Word {
	constructor() {
		this.string = '';
		this.uniqueChars = '';
	}

	addChar(char) {
		this.string += char;
		if (!this.uniqueChars.includes(char)) {
			this.uniqueChars += char;
		}
	}
}

function countWordsAndUniqueChars(data) {
	const words = [];
	let currentWord = new Word();

	for (let i = 0; i < data.length; i++) {
		const char = data[i];

		// Skip non-alphanumeric characters and line breaks
		if (!char.match(/[a-zA-Z\d]/)) {
			if (currentWord.string) {
				words.push(currentWord);
			}
			currentWord = new Word();
			continue;
		}

		currentWord.addChar(char);
	}

	// Process the last word if it exists
	if (currentWord.string) {
		words.push(currentWord);
	}

	const wordCount = words.length;
	const output = `Number of words in this sentence: ${wordCount}\n`;

	const wordResults = words
		.map(({ string, uniqueChars }) =>
			`Number of unique characters in the word ${string}: ${uniqueChars.length}`
		)
		.join('\n');

	console.log(output + wordResults);
}

countWordsAndUniqueChars(data);