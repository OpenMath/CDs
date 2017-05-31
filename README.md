# The OpenMath Content Dictionaries

This repository contains the [OpenMath](http://openmath.org) content dictionaries

* `cd` contains the actual content dictionaries, there are two 
* `sts` contains the small type system type annotations
* `build.xml` allows to run the html generation for [the OpenMath Web Site](http://www.openmath.org/cd), the other `*.xml` will probably be moved to the web site repository.
* `lib` contains resources for the build

To build the web site just run `ant` in the top dir, the web site is generated into the directory `target`. It only needs to be committed there. This wil probably be automated with travis in the near future. 

# Contributing Content Dictionaries

The [OpenMath Society](society) is actively soliciting CD submissions in all fields of mathematics. To submit a CD make a pull request:

1. [Fork this repository](https://github.com/OpenMath/CDs/compare#fork-destination-box)
1. develop your CDs in the fork (i.e. a file with name `*.ocd` in the `cd/experimental` directory)
1. make a pull request on your fork (via the "new pull request" button under the magenta line and on this page via the green "create pull request" button. 
1. add the following information in the comment
  * 'authors': who is responsible (other than the person submitting the pull request) 
  * 'purpose': why do we need these CDs
  * 'description': This will be inserted into the index file for the contributed CD directory.

