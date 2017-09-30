# The OpenMath Content Dictionaries

This repository contains the [OpenMath](http://openmath.org) content dictionaries. 

* `cd` contains the actual content dictionaries, there are two kinds official and experimental ones. 
* `cdgroups` contains the CD groups specifications. 
* `sts` contains the small type system (STS) libraries.
* `contrib` contains the contributed CDs and and STS libraries. 
* `make-all`, `lib`:  generates local html and other versions CDs (`lib` contains the necessary scripts and resources) 
* `run`, `.travis.yml`: automates html generation and pushes them to  [the OpenMath Web Site](http://www.openmath.org/cd) (via travis).

All CD development of the OpenMath Society is channeled through this repository. The `master` branch corresponds to the CDs published on the [OpenMath Web site](http://openmath.github.io). 

# Contributing Content Dictionaries

The [OpenMath Society](society) is actively soliciting CD submissions in all fields of mathematics. To submit a CD make a pull request:

1. [Fork this repository](https://github.com/OpenMath/CDs/compare#fork-destination-box)
1. develop your CDs in the fork (i.e. a file with name `*.ocd` in the `cd/contrib` directory)
1. make a pull request on your fork (via the "new pull request" button under the magenta line and on this page via the green "create pull request" button. 
1. add the following information in the comment
  * 'authors': who is responsible (other than the person submitting the pull request) 
  * 'purpose': why do we need these CDs
  * 'description': in a nutshell, what is in the new CDs

# Commenting on Content Dictionaries

We use the [GitHub issue system](issues) to discuss and plan changes to the CDs.  Note that there are a lot of issues left over from [a  previous discussion](OpenMath/OM3/issues), which may still be relevant.  
# Admin: publishing CDs on the OpenMath Web Site

After any edit to the CDs is pushed to the GitHub CDs repository, the html views will be rebuilt via Travis CI
and published, along with the updated CD files, on the OpenMath Web site.
The makefile supplied allows this process to be done locally if desired.
Note that you can avoid triggering a rebuild via Travis CI by starting the commit message with
`[ci skip] `

To update the [OpenMath Web site](http://openmath.github.io) manually, locally run `run` in the top dir, assuming that the [OpenMath.github.io](https://github.com/OpenMath/OpenMath.github.io) repository is cloned as a sibling to the [CDs](https://github.com/OpenMath/CDs) repository.
`run` automatically commits and pushes there.
However normally this is not necessary, continuous integration via Travis CI will rebuild the HTML view of all files after any commit is pushed to GitHub, and commit the resulting files to the OpenMath (GitHub) website, or send an email on failure.

# Version History

This repository contains a fresh copy of the current CDs. The development history of the
OpenMath CDs has been retained as part of the repository https://github.com/OpenMath/OMSVN
(warning there are copies of the CDs in various places).
<!--  LocalWords:  sts ocd contrib
 -->
