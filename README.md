This code relies on [pkgx](https://pkgx.sh/?via=curl) to manage the versionned binary dependencies.  
Install it first.
```bash
$ curl -Ssf https://pkgx.sh | sh
```

## Usage
```bash
$ pkgx task
task: Available tasks for this project:
* build:                            Build image
* clone:                            Clone github-actions-runner github repository
* default:                          List tasks
* init:                             Initialize packer
* patch_configure-enviroment:       Patch configure-environment.sh
* save:                             Save image
```

## Build an image
```bash
$ pkgx task build
...
```