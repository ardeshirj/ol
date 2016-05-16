# OL - OwnLocal
[![Build Status](https://travis-ci.org/ardeshirj/ol.svg?branch=master)](https://travis-ci.org/ardeshirj/ol)

Simple Rails API app for the interview project at OwnLocal. The `data.csv` has been provided by OwnLocal.

This rails-api app uses `Active Model Serializers (AMS)` & `Kaminari` to serialize & paginate the businesses data in JSON format. There are different kind of `adapters` that you can use with `AMS`. For this project the adapter is set to `JSON` since it has the closet format to the provided example:

```shell
curl -H "accept: application/vnd.ol+json; version=1" http://localhost:3000/businesses/1

{
  "businesses": [{
    "id": 1,
    "name": "...",
  }, ],
}
```
You can set the `AMS` adapter at `config/initializers/ams.rb`. For example you can change it to `json_api` which provide `pagination links` as well as metadata. rails-api suggest to use `json_api`, and you can read more about it [here](http://jsonapi.org/)

## Setup
```shell
# Install required gems from Gemfile
bundle install

# Create & seed the database
rake db:setup

# Start the rails server
rails s
```

## Test
The tests has been written in `rspec` and you can find the request tests at `spec/requests/businesses_spec.rb`.
```shell
# Setup test db
rake db:setup test

# Run all specs
rspec spec/
```

## Routes
The routes that provided by this api.

Please note the JSON example are not complete, and it is just used for demonstration purposes

### GET /businesses

By default this route will provide you the first 50 business objects including the pagination `meta` data:

```json
{
  "businesses":[{
    "id":0,
    "uuid":"123",
    "name":"xyz",
  }, ],
  "meta":{
    "current_page":1,
    "next_page":2,
    "prev_page":null,
    "total_pages":1000,
    "total_count":50000
  }
}
```
### GET /businesses?page=2&per_page=20

You can also customize the `page` and `per_page` in query parameters.

`page`: the page number

`per_page`: the number of business(es) items you want to have in a page

### GET /businesses/:id

This route will return an individual business item.
```json
{
  "business":{
    "id":0,
    "uuid":"123",
    "name":"xyz",
  }
}
```
Note if the item with the provided id doesn't exist then the response include the `404` error code and an error message (Couldn't find Business with 'id'=:id)
