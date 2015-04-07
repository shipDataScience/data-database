Database Connect Module
==============

An example data plugin for Ship Data Science.
Downloads data from an arbitrary database and saves to a file specified by the environment variable $SDS_OUTPUT_PATH.
To use, simply add the following code to your model's .shipit.json.
You can automatically fill out the config at the [Ship Data Science Cofigurator](http://configurator.shipdatascience.com).

```
"data" : {
  "module" : {
    "repositoryOwner": "shipDataScience",
    "repositoryName": "data-database",
    "repositoryBranch": "master"
  },
  "config" : {
    "database" : {
       "sql" : "",
       "adapter" : "",
       "user" : "",
       "password" : "",
       "host" : "",
       "port" : "", 
       "databaseName" : ""
    },
    "options" : {
      "quoteChar" : "",
      "delimiter": "",
      "headers": []
    }
  }
}
```

FAQ
--------
This container presently supports Postgres and MySQL.

This query is neither parallilized nor batched so performance is not optimal for large datasets.
We recommend power users write their own data module or fork and modify this one for better control over data pulling and security.
  
Security Note
----------

Be aware that your database connection information will appear in plaintext in .shipit.json if you use this module. 
At minimum you should ensure that your project repository on Github is set to private access only. 

Be aware this plugin runs arbitrary SQL code (whatever you specify in the field: sql). It's best practice to give read-only credentials to the
database user you specify and make sure that all queries are approved by the data owner.

License
-----------
Copyright (c) 2015 Ship Data Science LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

