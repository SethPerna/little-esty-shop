# Maintenance Tracker 
> "Little Esty Shop" is a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.
## Table of Contents
* [General Info](#general-information)
* [Installation](#installation)
* [Usage](#usage)
* [Technologies Used](#technologies-used)
* [Featured Applications](#featured-applications)
* [Room For Improvement](#room-for-improvement)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)

## General Information
This solution contains a Ruby on Rails Web Application using MVC architecture:
- Utilizes custom data tables with foreign key relationships
- Manage customers, merchants, items transactions and invoices
- [Database Schema Diagram](https://dbdiagram.io/d/61b0e0908c901501c0e724a4)


## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)
