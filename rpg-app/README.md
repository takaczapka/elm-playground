Elm version 0.18

# Backend

Json-server (npm package) - a quick way to create fake APIs or simplistic text based json DB.
See api.js and db.json.

```
npm init
npm i json-server@0.9 -S
```

Start with ```node api.js```

# Front end

## Webpack
Using Webpack to package the Elm app.

webpack version 1.13, elm-webpack-loader version 4.1

```
npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@4 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
npm i ace-css@1 font-awesome@4 -S
```

## Elm
```
elm package install elm-lang/html
```

# Running together

We have two servers to run for developing: the Api and the Frontend - we will need to launch both manually to test our application, this is ok but there is a better way.
Install Node Foreman:
```
npm install -g foreman
```
Then create a file called `Procfile` in the root of the project with:
```
api: npm run api
client: npm run dev
```

This will give us a cli command called nf that allows to launch and kill both processed at the same time.

Run:
```nf start```
