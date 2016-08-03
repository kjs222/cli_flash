### Getting Started

This is the command line application to be used with the [codepoints app](www.codepoints.herokuapp.com).  You must activate the command line app from codepoints in oder to use.


Clone the repo to your desired directory:

`git clone https://github.com/kjs222/cli_flash`

To see your path:

`echo $PATH`

Add a symbolic link in your path to point to the download program:

`ln -s <path to app>/cli_flash/bin/quizlet /usr/local/bin/codepoints`

### To Use

Now you can run the program:

`codepoints help`

Commands:

 `codepoints add_term TITLE`      # adds a term to a set

 `codepoints help [COMMAND]`      # Describe available commands or one specific command

 `codepoints new_set TITLE`       # adds a set to quizlet

 `codepoints quizsets`            # Returns the titles for all of your quiz sets

 `codepoints setup UID PASSWORD`  # gets token and sets it as env variable

 `codepoints start SKILL_NAME`    # starts a practice session

 `codepoints stop SKILL_NAME`     # stops a practice session

 `codepoints terms TITLE`         # gets terms and displays them as output
