DB Data Grabber
==============

An example data plugin for Ship Data Science.
Downloads data from an arbitrary database.
To use, simply add the following code to your model's .shipit.json.

```
"data" : {
  "clone_url" : "THIS_REPO_URL",
  "args" : {
     "sql" : "",
     "adapter" : "",
     "user" : "",
     "password" : "",
      "host" : "",
      "port" : "", 
      "databaseName" 
  }
}
```

FAQ
--------
Here is what happens to your data when you run a build:

 - A fresh virtual machine is spun up on AWS. This VM is only used for this build and deleted on termination.
 - Your model is cloned to the box using your Github oauth token.
 - This data plugin's environment is built using the Dockerfile.
 - This data plugin's docker container is started and the script writes your data to a mounted volume (a segregated file directory on your VM).
 - The docker container image is deleted and the data plugin is done.
 - Each monitoring plugin container you have selected is run sequentially and given access to the data directory.
 - The plugin results are sent to our server and the VM is terminated.
  
Security Note
----------
This plugin relies on an IAM account key stored in plaintext in your model Github repository---please make sure your repository is set to private to
avoid exposing your credentials. Storing config info with us instead of Github is on the roadmap but for now, please be aware!

Additionally, be aware this plugin runs arbitrary SQL code (whatever you specify in the field: sql). It's best practice to give read-only credentials to the
database user you specify and make sure that all queries are approved by the data owner.


