# Travis CI Integration
[Travis CI](https://travis-ci.org/) is integrated with Trailhead for the original repository. Upon any github commit, Travis CI is triggered. This will build and run the app on a simulator (currently iPhone Xʀ 12.4) as well as all unit and UI tests.

## Build Status
![Travis (.org)](https://img.shields.io/travis/mattwhitlock/Trailhead)

Travis CI results can be found [here](https://travis-ci.org/mattwhitlock/Trailhead).

## Code Coverage
![Codecov](https://img.shields.io/codecov/c/github/mattwhitlock/Trailhead)

In addition, [Codecov](https://codecov.io/) is used to provide code coverage information as well.

Codecov results can be found [here](https://codecov.io/gh/mattwhitlock/Trailhead).


## Adaptation to new project
In order to adapt the Travis CI and Codecov to a new project, follow the steps below. Note that for close source work you will need a [paid Travis CI account](https://travis-ci.com/plans), and may need a [paid Codecov account](https://codecov.io/pricing).

### 1. Update .travis.yml
* In the root of the repository, open .travis.yml.
* Change following if needed
   * `osx_image:`
   * `xcode_project:`
   * `xcode_scheme:`
   * `xcode_destination:`

### 2. Update tokens
**Travis CI Github Token**

A secure token is needed for Travis CI to work with Github. For open source projects this is to avoid rate limiting. For closed source this is to allow access to the repository.

To generate the token:  
1. Go to [https://github.com/settings/tokens](https://github.com/settings/tokens)  
2. Under the Personal access Tokens group, click `Generate new token`  
3. Provide it a name (`Travis`  or similar)  
4. Check the box for `repo`  
5. Click `Generate token`  
6. Copy the generated token and save in a safe place (Lastpass or 1Password)

To add the token to the repository:  
1. Install Travis CLI if it's not already installed: ```sudo gem install travis```  
2. In the same folder as .travis.yml, run the following: ``` travis encrypt GITHUB_ACCESS_TOKEN=<token> --add env.global ``` which will add the github secure key to the .travis.yml file.  

**Travis CI Codecov Token**

A secure token is also needed for Travis CI to work with Codecov. The process is similar to that for the Github token.

To generate the token:  
1. Follow the [Codecov](https://codecov.io/) getting started process  
2. Copy the token presented into a safe place  

To add the token to the repository:  
1. run ``` travis encrypt CODECOV_TOKEN=<token> --add env.global ```
