# OL - OwnLocal
Simple Rails API app for the interview project at OwnLocal. The `data.csv` has been provided by OwnLocal.

This rails-api app uses `Active Model Serializers (AMS)` & `Kaminari` to paginate the businesses data in JSON format.

The `AMS` gem is helping us to serialize the businesses data. There are different kind of `adapters` that you can use with `AMS`. For this project the adapter is set to `JSON` since it has the closet format to the provided example:

```json
{
  "businesses": [{
    "id": 1,
    "name": "...",
    ...
  }, ...],
  ...
}
```
You set your different json adapters at `config/initializers/ams.rb`. For example you can change it to `json_api` which provide `pagination links`.

rails-api suggest to use `json_api` and you can read more about it (here)[http://jsonapi.org/]

## Setup
```shell
# Install required gems from Gemfile
bundle install

# Create & seed the database
rake db:setup

# Start the rails server
rails s
```

## Routes
- GET /businesses
By default this route will provide you the first 50 business objects including the pagination `meta` data:

```json
{
  "businesses":[{
    "id":0,
    "uuid":"123",
    "name":"xyz",
    ...
  }, ...],
  "meta":{
    "current_page":1,
    "next_page":2,
    "prev_page":null,
    "total_pages":1000,
    "total_count":50000
  }
}
```
- GET /businesses?page=2&per_page=20
You can also customize the `page` and `per_page` in query parameters.
`page`: the page number
`per_page`: the number of business(es) items you want to have in a page

- GET /businesses/:id
This route will return an individual business item.
```json
{
  "business":{
    "id":0,
    "uuid":"123",
    "name":"xyz",
    ...
  }
}
```
Note if the item with the provided id doesn't exist then the response include the `404` error code and an error message (Couldn't find Business with 'id'=:id)