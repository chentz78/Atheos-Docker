# [Atheos IDE](https://atheos.io/), updated from [Codiad](http://codiad.com/)

## What is Atheos


<img src="https://www.atheos.io/assets/images/screenshot.png" title="Atheos" style="max-width:100%;">

Atheos is an updated and currently maintained fork of Codiad, a web-based IDE framework with a small footprint and minimal requirements. 

Codiad was built with simplicity in mind, allowing for fast, interactive development without the massive overhead of some of the larger desktop editors. That being said even users of IDE's such as Eclipse, NetBeans and Aptana are finding Codiad's simplicity to be a huge benefit. While simplicity was key, we didn't skimp on features and have a team of dedicated developer actively adding more.

Atheos is expanding on that mentality as much as possible, trying to minimizing it's footprint even further while maximizing functionality and performance. The major goal of Atheos will be a complete rewrite of every line of code, from the bottom to the top, including plugins; Reason being that Codiad was built over a long period of time, and older files still use much older standards. Codiad has a lot of technical debt piled up that needs addressing.

For more information on the project please check out **[the docs](https://www.atheos.io/docs)** or **[the Atheos Website](http://www.atheos.io)**

## How to use this image

    docker run --rm -p 8080:80 -d hlsiira/atheos

Then open your browser at `http://localhost:8080`.

**Parameters:**

  * `-p 80` ‒ the port to expose.

### Extending the capabilies

You can easily extend to include tool you may need and have them ready
whenever you re-create your container. Just create a `Dockerfile` like:

    FROM hlsiira/atheos
    RUN apt update && apt install -y build-essential python

Now you can just build and use your new image:

    $ docker build -t atheos .
    $ docker run --name atheos --rm -p 8080:80 -d hlsiira/atheos


## Feedback

Suggestions are welcome on the [GitHub issue tracker](https://github.com/Atheos/Atheos-Docker/issues).
