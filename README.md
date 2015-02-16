lgdock is a tool for preparing LaTeX papers. It depends on having Docker and Gradle installed on a host,
and also works with [boot2docker](http://boot2docker.io/).

## Usage

To start, you can clone this repository or otherwise drop build.gradle into your paper's directory.
You will need to have Gradle and Docker installed. Your Docker installation will need to expose
its HTTP interface. If you are using [boot2docker](http://boot2docker.io/) on a Windows or Mac computer, this is the
default configuration. If you are on a Linux host with Docker directly installed, check out
[this blog post](http://www.virtuallyghetto.com/2014/07/quick-tip-how-to-enable-docker-remote-api.html).

Once you have tools installed, you need to tell gradle where to find Docker and your LaTex file:
* base: the base name to use for you final LaTex files
* dockerUrl: the path to your URL, including protocol, host, and port (e.g., https://192.168.59.103:2376)
* source: Your LaTeX input file

The script uses Gradle properties for this. You can use the provided gradle.properties file to define them 
OR just set properties from the command line like so:

```
gradle -Psource="parts.tex" -Pbase="example" -PdockerUrl="https://..." ...
```

With these properties set, you can now run tasks on the given sample files. A simple build
of a PDF currently requires running two tasks explicitly.
(Hopefully, these can be safely linked in the future!)

```
gradle buildImage
gradle buildPaper
```

This will produce "example.pdf" in your current directory. Note that buildImage only needs to occur
once, or upon modification of the build.gradle's Dockerfile (read more about internals below).

buildPaper also runs a task singleFile to convert your input LaTeX file to a single LaTeX source. This
allows the input file to use the "input" command to define and reference external LaTeX sources. Because
"parts.tex" is defined as "source" and "example" as "base", parts.tex is converted into example.tex by
singleFile, and example.tex is converted into example.pdf by buildPaper. After running buildPaper or
singleFile directly, you will notice a new file example.tex generated. If you compare this file
to the original parts.tex, you will see the "input" command replaced with the actual content of
"hello.tex".

Conversion to a single LaTeX source is often required for conference and journal submissions. In the
future, it also should be possible with the tool to skip the singleFile task - but this is not
yet implemented.

## Available Tasks

### More documentation coming soon!

Available tasks are:
* buildImage - build the base Docker image
* buildPaper - Run the sequence of pdflatex, bibtex, pdflatex, pdflatex to generate a PDF with optional
bibliography (will also run singleFile)
* cleanAll - remove paper files and the Docker image. NOT recommended unless you are tweaking the image
* cleanPaper - remove intermediate paper files
* generateFigure - generate a LaTeX figure block, given an image
* generateTable - generate a LaTeX table block, given a CSV file of raw data
* runRscript - run an R script and save output
* singleFile - produce a single LaTeX file from a file which uses "input" commands

## Under the Covers

The Dockerfile is defined inline in the build.gradle script. It installs a basic set of texlive packages
and R statistics packages. The Gradle tasks run some commands locally and some within Docker containers.

When running in Docker containers, the current directory is mounted as the location "/papers" in the
container thanks to a Volume.

I am using the [docker-java](https://github.com/docker-java/docker-java) library to communicate
with the Docker host over its Remote API.

To extend this setup, just define additional tasks in the build.gradle script. If you want to run
a new LaTeX or R command, you should check out the doCmd helper function in the Gradle script, which
runs a given String as a command in the Docker container.

If you need to install additonal dependencies in the Docker container, look at the multi-line String
defined as "dockerfileContent". You'll see several examples of installing Ubuntu packages. Note that
after any modifications to this String, you will need to run buildImage.

## Why Bro?

It may seem like Gradle and Docker are much heavier dependencies than the likes of LaTeX and R. First,
I'm not 100% sure that's the truth, because LaTeX distributions tend to be HUGE and their packages
(especially away from *nix) interweaved. However, I still like
the portability of having a known LaTeX and R setup that goes with me. Also, boot2Docker is very easy
to install, and affords users the ability to use these tools in their more natural *nix environment
without having to remember all of the quirks by hand.

## What's next?

I think this could be a pretty useful tool for making LaTex and R more usable. It's my plan to
continue to expand the tasks available here as I have a need for them myself.

I probably won't have time to make things and pretty and robust as I'd like,  as I'm currently
working full-time on top of working on dissertation research. If you do have ideas or questions,
feel free to post an issue or send me a Pull Request.

Thanks for stopping by!
