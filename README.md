CodePoints is a productivity app aimed at new programmers. It helps new learners set learning goals, track learning activities, see historical practice information, follow other users, and maximize the use of the Quizlet flashcard program to learn programming skills.

This is the command line application to be used with the [codepoints webapp] (https://codepoints.herokuapp.com/).  You must activate the command line app from the website in order to use.

This app uses the Thor gem and consumes the Quizlet API as well as the Codepoints API.

See blog posts [here](https://www.turing.io/blog/2016/08/30/where-begin-solve-problem-you-know-well) and [here](https://medium.com/@KerrySheldon/customized-activity-feeds-in-rails-c6009f54c68b#.qlw033uci) for more information on the app.


### Getting Started

This is the command line application to be used with the [codepoints app] (https://codepoints.herokuapp.com/).  You must activate the command line app from the website in order to use.


Clone the repo to your desired directory:

`git clone https://github.com/kjs222/cli_flash`

To see your path:

`echo $PATH`

Add a symbolic link in your path to point to the download program:

`ln -s <path to app>/cli_flash/bin/quizlet /usr/local/bin/codepoints`

### To Use

Now you can run the program:

`codepoints help`

To setup your credentials one time, you must use the following command (UID is your codepoints nickname and password is your codepoints password)

`codepoints setup UID PASSWORD`  # gets token and sets it as env variable


All commands:

 `codepoints add_term TITLE`      # adds a term to a set

 `codepoints help [COMMAND]`      # Describe available commands or one specific command

 `codepoints new_set TITLE`       # adds a set to quizlet

 `codepoints quizsets`            # Returns the titles for all of your quiz sets

 `codepoints setup UID PASSWORD`  # gets token and sets it as env variable

 `codepoints start SKILL_NAME`    # starts a practice session

 `codepoints stop SKILL_NAME`     # stops a practice session

 `codepoints terms TITLE`         # gets terms and displays them as output
