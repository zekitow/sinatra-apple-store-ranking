# Apple Store Ranking API

A simple API to provide ranking information of Apple Store Rankings (Free, Paid, Grossing).

## Requirements

This API was developed using RVM and Ruby 2.2.2. if you do not have It installed, please follow this [instructions](https://rvm.io/).

## Running

Clone the project and run the **bundle** command inside the root folder:

    bundle install

## Starting Sinatra

In terminal, runs the command bellow and visit the url **http://localhost:4567/apple-store/category**

    ruby app.rb

## Running the tests

The tests was developed using Rspec, VCR, webmock and json-schema. To run the scenarios just use the command bellow:

    rspec .

Then you should see something like:

  ```
    ...................
    Finished in 0.35066 seconds (files took 0.70279 seconds to load)
    19 examples, 0 failures
  ```

## API Specifications

### Endpoint /apple-store/category

| Param            | Description                        |  Required | Type     | Domain                              |
|------------------|------------------------------------|-----------|----------|-------------------------------------|
| genreId          | app category                       | true      | Integer  | [All available Categories](https://affiliate.itunes.apple.com/resources/documentation/genre-mapping/) |
| monetizationType | monetization (Free, Paid, Grossing)| true      | Integer  | Free (27), Paid (30), Grossing (38) |
| position         | rank position                      | no        | Integer  | Between 1 and 200                   |


#### Behavior


| URL                                                                  | Status Code    | Reason                                       |
|----------------------------------------------------------------------|----------------|----------------------------------------------|
| /apple-store/category                                                | 422            | Missing required Params                      |
| /apple-store/category?genreId=0&monetizationType=0                   | 404            | genreId or monetizationType not found        |
| /apple-store/category?genreId=6001&monetizationType=27&position=1000 | 404            | Rank position not found                      |
| /apple-store/category?genreId=6001&monetizationType=27               | 200            | genreId and monetizationType found           |
| /apple-store/category?genreId=6001&monetizationType=27&position=1    | 200            | genreId, monetizationType and position found |


##### Status 422 Body Example


  ```json
    {
      "message": [
        "genreId is required.",
        "monetizationType is required."
      ]
    }
  ```

##### Status 404 Body Examples
###### genreId or monetizationType not found

  ```json
    {
      "message": "genreId or MonetizationType not found."
    }
  ```


###### Ranking position not found

  ```json
    {
      "message": "Ranking position not found."
    }
  ```


##### Status 200 Body Example

  ```json
    {
      "top_publishers": [
      {
        "publisher_id": 413063859,
        "publisher_name": "Publisher name",
        "number_of_apps": 2,
        "app_names": ["App name 1", "App name 2"],
        "position": 1
      }
      ],
      "ranking": {
        "rank_title": "Top Free iPhone Apps",
        "apps": [
        {
          "id": 281940292,
          "publisher_name": "Earth Networks, Inc.",
          "publisher_id": 281940295,
          "icon": "http://app-icon-address/icon.jpg",
          "description": "Description of the App",
          "app_name": "Name of the App",
          "price": 0,
          "version": "4.4",
          "avg_rating": 3.5,
          "position": 1
        }
        ]
      }
    }
  ```