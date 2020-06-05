# migrant-worker-rails
A web application and a backend application for [migrant-worker-mobile](https://github.com/hengsokly/migrant-worker-mobile).

## Getting Start

### Prerequisites
- Make sure your environment is set up with [docker](https://www.docker.com/get-started).

#### Clone repo
```
$git clone https://github.com/hengsokly/migrant-worker-rails.git
```
- Rename ```app.env.example``` to ```app.env```
- Replace those environment variable with your own data

#### Database creation
```
$docker-compose run --rm web bash
$bundle exec rake db:create
$bundle exec rake db:migrate
$bundle exec rake sample:load

```
#### Run the application
```
$docker-compose up
```
#### Run spec
```
$docker-compose run --rm web bundle exec rspec
```

## Deployment instructions
- Compile the project as a docker image
```$ docker build -t ilabsea/migrant-worker-rails:0.0.1 .```
- Push it to docker hub
```$ docker push ilabsea/migrant-worker-rails:0.0.1```

**Important**: change version base on your release

- ssh to server
```
$ssh username@domain
$cd ~
$mkdir migrant-worker-rails
```
- Copy ```docker-compose.prod.yml``` to the folder
```
local$scp /var/www/migrant-worker-rails/docker-compose.prod.yml username@domain:~/migrant-worker-rails/docker-compose.yml
```
- In ```docker-compoes.yml```,
  - Update app service image version. ex: ```ilabsea/migrant-worker-rails:0.0.1```
  - Update environment variable to production

#### Database creation
```
$docker-compose run --rm app bundle exec rake db:create
$docker-compose run --rm app bundle exec rake db:migrate
```
#### Run the application in background process
```
$docker-compose up -d
```
