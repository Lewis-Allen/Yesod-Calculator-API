# Yesod Calculator API

The Yesod Calculator small RESTful API built with the Yesod Framework. It's goal is to simulate the basic operations of a calculator such as addition and subtraction. As well as this it's intention is to demonstrate the ability to provide both authentication, authorisation and persistence in a haskell environment.
 
## Current Features
- Arithmetic Operations.
- Authentication with support for both authenticated and unauthenticated requests.
- Persistent database storage. 
- Calculation history by user. 
- Nth digit of Pi calculator. 

## Getting Started 

### Prerequisites

The Calculator API requires the following installed:
* Stack Build Tool 
* Cabal Dependancy Manager
* Yesod Command Line Tool

### Installing

1. Clone the GitHub repository in a directory of your choosing.
  * `git clone https://github.com/Lewis-Allen/Yesod-Calculator-API`
2. Navigate into the new Yesod-Calculator-API directory
  * `cd Yesod-Calculator-API`
3. Build the Project
  * `stack build && stack exec my-project`

## Running Tests
Tests are run automatically through the stack tool
* `stack test`

## References

-- __Yesod Web Framework Book__ by Michael Snoyman - Authentication, Shakespearean Templates, Persistence.
-- __Unbounded Spigot Algorithms for the Digits of Pi__ by Jeremy Gibbons - Formulae for calculating infinite list of pi. 