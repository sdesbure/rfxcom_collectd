rfxcom_collectd
===============

A node.js server which will grab information from rfxcom receiver and send them to collectd

it currently support only Oregon Temperature/Humidity probes

## Install

In order to make it work do the following (assuming that node.js is installed. Otherwise, install node.js first):

clone it:

```bash
$ git clone https://github.com/sdesbure/rfxcom_collectd.git
```

go to the directory and install the needed packages (coffee-script is needed only if you want to hack it a little bit):

``` bash
$ cd rfxcom_collectd
$ npm install collectdout require-yaml rfxcom coffee-script
```

configure the yaml file accordingly. Here's the default file where you need at least to put the good id for the probes:

``` yaml
---
  collectd: # where your collectd server is
    host: "localhost"
    port: 25826
    interval: 10000 # in ms
  rfxcom: # usb port where rfxtrx433 is connected. May work also with rfxlan. see https://github.com/bigkevmcd/node-rfxcom
    usb: "/dev/ttyUSB1"
  probes: # description of each probe where we want to retrieve values. Currently only Oregon Temp/Humidity probes are retrieved. Very easy to add new type. see rfxcon_collectd.coffee file and https://github.com/bigkevmcd/node-rfxcom to see how to do
    one:
      name: "Probe one"
      id: "0x1234" # as seen in "debug mode" (comment out all console.log line and add ", debug: true" in RfxCom initialization in rfxcon_collectd.coffee file
      type: "oregon-th"
      channel: 1
    two:
      name: "Probe two"
      id: "0x5678"
      type: "oregon-th"
      channel: 2
```

launch the script:

``` bash
$ node rfxcom_collectd.js
```

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Try to add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 Sylvain Desbureaux. See LICENSE for details.
