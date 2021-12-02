# SpiderBox Design Ruby on Rails Assessment

## THE URL SHORTENER CHALLENGE
Prerequisites: machine has installed docker and docker-compose

Step by step to setup project:
1. Move to path of container docker-compose.yml file, make sure perrsion of folder and file (use command chmod -R 777 to folder parent)
2. Run command to build project: docker-compose up --build
3. Open browser, go to url to visit the website: http://localhost:3000

--------------------------------------------------------------------------------------------------------
The algorithm used for generating the URL shortcode:
1. Generate a string include 6 character random from a-z, 0-9
2. Execute loop, check this string exist in DB, if yes => regenerate, if no => exit loop and save it into DB
3. When user want to get shortlink, server will combine its domain and this string to create shortlink

--------------------------------------------------------------------------------------------------------
Database structure:
1. Table "users": information of users include name, email, password
2. Table "urls": information of url include long url (original url), short url, short url clicks

---------------------------------------------------------------------------------------------------------
API Description:
1. API access all my links: 
- Content: get information all links of user
- URL: http://localhost:3000/api/urls
- Method: GET
- Params: offset and limit (if there's no param, API will response all data)
- Authorization: user:password
Example: curl -v -X GET http://localhost:3000/api/urls?limit=3&offset=0 -u phumv1:123456

2. API shorten new URLs
- Content: create new short url with input URL original
- URL: http://localhost:3000/api/url
- Method: POST
- Param: long_url
- Authorization: user:password
Example: curl -i -X POST -d "long_url=http://google.com" 'http://localhost:3000/api/url' -u phumv1:123456
testing

