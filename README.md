lgdock is a tool for preparing LaTeX papers. It only depends on having Docker installed on a host, and also works with boot2docker.

Planned functions:
* make - convert paper source into a pdf
* addRef - add a LaTeX reference to a bibliography
* genFigure - generate a figure from source data
etc. etc.

This is currently a work in progress. The current commit includes the ACM SIG LaTeX template, though working with
any given should be possible in the future.

The basic idea is to use Gradle as a "build tool" for papers, and a Docker container as a host
for necessary tools (e.g., LaTeX, R, etc.). The Docker container can check out source from Github and run Gradle
builds. The same Github source can be used on the Docker host to run high-level commands like "make", which call
docker to carry out tasks.

One interesting open question is how to get artifacts out of the Docker containers. We could use volumes,
or we could temporarily host to a lightweight webserver for download. Will have to try this out.
