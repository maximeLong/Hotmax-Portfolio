# portfolio

> portfolio site three js project

## Build Setup

``` bash
# install dependencies
cd app && npm install

# serve with hot reload at localhost:8080
cd app && npm start


# build for production
npm run build (saves minified code to whichever path you provide in build config)
git push origin master (master branch is up to date)

# building to a heroku app - we can ignore this for right now because I think we'll be using Surge
heroku login
git subtree push --prefix <server folder> heroku master (makes git subtree repo of server path)

```

Vue loader docs: [guide](http://vuejs-templates.github.io/webpack/)
