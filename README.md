lgdock is a tool for preparing LaTeX papers. It only depends on having Docker installed on a host, and also works with boot2docker.

Planned functions:
* make - convert paper source into a pdf
* addRef - add a LaTeX reference to a bibliography
* genFigure - generate a figure from source data
etc. etc.

This is currently a work in progress. The current commit includes the ACM SIG LaTeX template.


The basic idea is to use Gradle as a "build tool" for papers, and a Docker container as a host for necessary tools (e.g., LaTeX,
R, etc.). The Docker container can check out source from Github and run Gradle builds. The same Github source can be used on
the Docker host to run high-level commands like "make", which call docker to do work.
