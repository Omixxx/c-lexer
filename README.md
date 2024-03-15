## About the project

Simple script that, through this [gem](https://github.com/intersimone999/code-lexer) (currently the branch `feature/spaces-handling`),
allows you to tokenize the json results of the tool [clarity](https://github.com/Omixxx/clarity)

## Setup

1. make sure you have ruby installed

2. run `gem install code-lexer`

3. clone the project [code-lexer](https://github.com/intersimone999/code-lexer)

4. go to `~/.local/share/gem/ruby/3.0.0/gems` and replace the folder `lib` with the folder `lib` which is found in the project `code-lexer` just cloned (make sure you are in the branch `feature/spaces-handling`, otherwise you will encounter errors)

## Usage

Run `ruby lex.rb clarity_results_path`
