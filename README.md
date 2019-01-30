# Book Club
https://infinite-harbor-31716.herokuapp.com/

A Turing School paired project created with Rails.

![Book Club](/.readme/books.jpg)


We created an online application where users can browse and review books and authors. A user can add, update, or delete a book, a review, or an author.

![Book Club](/.readme/book.jpg)

## Learning Goals
The primary goal of this challenge was learning how to set up many-to-many relationships and accessing attributes through multiple models.

* Creation of a basic Rails web application
* Implementing basic MVC structure
* Save and retrieve data from a database
* Display content on a web page with basic styling
* Testing code effectively at a Controller and Model level

## Getting Started && Prerequisites

You will need Rails v 5.1.
```
gem install rails -v 5.1
```
Clone down this repo!

```
git clone https://github.com/mgoodhart5/book_club
```

### Installing

From your terminal, navigate into the book_club directory
```
cd book_club
```

Make sure your gemfile is up to date:

```
bundle
bundle update
```
Establish a database:

```
rake db:{drop,create,migrate,seed}
```
Start your server:

```
rails s
```

Open your browser (best functionality in Chrome).

`localhost:3000`

Welcome to our dev environment!


## Running the tests

Your location should be the root directory of the project (`book_club`).

From the command line run `rspec`
(This can take a moment)

`Green` is passing.
`Red` is failing.

We used `rspec`, `capybara`, and `shoulda-matchers` for testing.

##### Example of a feature test:

![test picture](/.readme/rspec.jpg)

##### Example of a Controller:

![book controller](/.readme/bookscontroller.jpg)

##### Example of a model:

![book model](/.readme/bookmodel.jpg)

##### Example of a view:

![user view](/.readme/view.jpg)

## ActiveRecord Queries and Statistics
We worked with a relational database and queries with many to many relationships.

##### Our Schema

![Alt text](/.readme/schema.jpg)

## Deployment

Our app is deployed on heroku at: [Book Club](https://infinite-harbor-31716.herokuapp.com/)

`https://infinite-harbor-31716.herokuapp.com/`

## Built With

* `Rails` (and all it's magic)
* Along with these gems:
  * `Rspec`
  * `Capybara`
  * `ShouldaMatchers`...and more!

## Contributing Members

* Mary Goodhart
* Anna Smolentzov
