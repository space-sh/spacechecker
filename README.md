# Spacechecker: module analysis | [![build status](https://gitlab.com/space-sh/spacechecker/badges/master/build.svg)](https://gitlab.com/space-sh/spacechecker/commits/master)

Performs analysis of other modules, looking for a set of properties and testing for conformance with _Space_ guidelines.



## /run/
	Run module analysis

	Takes a module directory path as input and perform analysis check on its contents.
	Example: space -m spacechecker /run/ -- .
	


# Functions 

## SPACECHECKER\_DEP\_INSTALL()  
  
  
  
Check dependencies for this module.  
  
  
  
## \_CHECK\_DEP\_INSTALL\_NODE()  
  
  
  
Check if module has dep\_install node implemented.  
  
  
  
## \_CHECK\_LICENSE\_FILE\_EXISTS()  
  
  
  
Check if module has LICENSE file present.  
  
  
  
## \_CHECK\_CHANGELOG\_FILE\_EXISTS()  
  
  
  
Check if module has CHANGELOG file present.  
  
  
  
## \_CHECK\_README\_FILE\_EXISTS()  
  
  
  
Check if module has README file present.  
  
  
  
## \_CHECK\_STABLE\_FILE\_EXISTS()  
  
  
  
Check if module has stable file present.  
  
  
  
## \_CHECK\_TESTS\_EXIST()  
  
  
  
Check if module has tests structure in place.  
  
  
  
## \_CHECK\_GITLABCI\_FILE\_EXISTS()  
  
  
  
Check if module has gitlab-ci file present.  
  
  
  
## \_CHECK\_BASHISMS()  
  
  
  
Check if module possibly has bashisms  
  
  
  
## \_CHECK\_MODULE()  
  
  
  
Check if module complies with Space module guidelines.  
  
### Parameters:  
- $1: module directory path  
  
### Returns:  
- 0: success  
- 1: failed. Directory path is not pointing to a module.  
  
  
  
