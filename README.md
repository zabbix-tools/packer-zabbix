# packer-zabbix
This repository provides Packer build configuration to automate the build of a
CentOS 7.0 x86_64 Vagrant box (VirtualBox) with the Zabbix server and agent
installed and preconfigured.

## Prerequisites

* Install and configure [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install and configure [Vagrant](https://www.vagrantup.com/downloads.html)
* Install and configure [Packer](https://www.packer.io/downloads.html)

## Build

The first build will download the CentOS 7.0 x86_64 Minimal ISO from the
configured mirror URL.

* Update the `iso_url` directive in the packer JSON file to your local mirror
* Ensure the `timezone`, `url` and `repo` directives are appropriate for your
  region in `files/anaconda-ks-7.0.cfg`
* Set the desired Zabbix version using the `ZBX_VER_*` variables in `Makefile`
* Simply run `make` to build the Vagrant box

## License

Copyright (c) 2015 Ryan Armstrong

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.