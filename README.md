# README
This Gallery API server parses *image_urls.csv* file and seeds the database with image records, urls and available dimensions. The seeding logic can be viewed in seeds.rb file. <br />

###API responds to 3 main routes:###
1. GET /v1/images/dimensions - the server responds with JSON that would look like `{dimensions: ['400/200']}`
2. GET /v1/images - with no params the server will respond with an object of paginated results. The object will look like<br />
`{records: [],entries_count: 48, pages_per_limit: 5, page: 1 }` <br />
The applications assumes the default of 10 records per page and 1st page requested if no params are passed. The route accepts pagination params as `per_page` and `page`. Both of them require integers and let you choose the page you want to see and how many records you want to paginate per page. (Pagination logic is custom and written in paginatable.rb).<br />
This route also accepts `dimensions` parameter, which should be passed in `xxx/xxx` format (example: `1280/800`, `640/480`, or both of them as an array: `["100/100", "200/200"]`) and it will respond with images that carry these dimensions, if they exist.
3. GET /v1/images/:id - responds with just one image object by ID param if it exists in the database or will return an error JSON object.

### Technologies

* Ruby 2.7.0

* Rails 6.0.2.1

* Postgres 12.2

### Running instructions
Make sure you have Ruby, Rails and Postgres versions available
### Install all gems
Install bundler if it isn't installed yet:  `gem bundler install`<br />
Install app gems `bundle install`
### Set up the DB
`rake db:create`
### Run DB migrations
`rake db:migrate`
### Seed the DB with image records
`rake db:seed`
### Run tests
`rspec`
### Run the application
You can start just the application by running `rails s`. It'll start on default port 3000. **But** if you're going to run it along *photoviewer_web* React application, I would recommend starting this API on port 3001, because *photoviewer_web* will refer to it by default. Run `rails s -p3001` to start it on a custom port
### See available routes
`rake routes`<br />
### Notes
Use Postman app or similar to make test requests. Read test suite to learn all potential functionality.