# portfolio

> portfolio site three js project

## Build Setup

``` bash
# install dependencies
cd app && npm install

# serve with hot reload at localhost:8080
cd app && npm start


# build for production, from
npm run build (saves minified code to whichever path you provide in build config)
git push origin master (master branch is up to date)

# building to a heroku app
cd portfolio root
heroku login
git subtree push --prefix app/dist heroku master (makes git subtree repo of server path)

```

## If dist folder doesn't contain package.json and server.js(express server), you'll have to create those as well for heroku deployment.
``` bash
# package.json
{
 "name": "hotmax",
 "version": "1.0.0",
 "description": "hotmax company site",
 "author": "Maxime Long",
 "private": true,
 "scripts": {
   "postinstall": "npm install express"
 }
}

# server.js
var express = require('express');
var path = require('path');
var serveStatic = require('serve-static');
app = express();
app.use(serveStatic(__dirname));
var port = process.env.PORT || 5000;
app.listen(port);
console.log('server started '+ port);
```

Vue loader docs: [guide](http://vuejs-templates.github.io/webpack/)
Guide to vue Cli/heroku deployment: [guide](https://medium.com/@sagarjauhari/quick-n-clean-way-to-deploy-vue-webpack-apps-on-heroku-b522d3904bc8#.n2by2m6ck)
