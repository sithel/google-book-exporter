# google_book_exporter
To pull aaaaaall those details out of the Google doc so that I can make a book from it!

This works using some very precise assumptions about the format of exported Google Doc files and is rather brittle.

Pulls down a single file and processes it. Marks it up and provides the raw text for a LaTeX file.

All of this work is being done mostly for Google comments. I'm sure there's lovely HTML (expored Google Doc file format) to LaTeX converters already, but there is some extra mangling/DOM juggling required to squeeze in all the comments as footnotes and highlight the commented upon text. Which, to my knowledge, Google Drive does not currently provide in any of it's export formats.

## ToDos:

* Host the page somewhere
* Handle duplicate comments with the same content (differentiate via highlighted text or raise as issue)
* Insert the uncovered issues/problems as comments into the LaTeX output
* Enable toggling of LaTeX header info so output can stand on it's own
* Enable spitting out custom LaTeX header (by itself with N `\include{filename}`s)
* Enable toggling of 4T specific markings (`jumpScene` and `sceneHeader`)
* Figure out how I want to embed images in the LaTeX
