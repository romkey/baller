# baller

Generates a skeletal *ball ESP32 or ESP8266 project that posts sensor values to a [Homebus](https://github.com/HomeBusProjects/homebus) broker.

## Usage

```
bin/baller new NAME --mit --git --sensors # --esp32 --esp8266
```

Generates a PlatformIO project in the `NAME` directory supporting `#` sensors.

### Options

- --mit include the MIT License
- --git initialize a local git repository for the project
- --sensors NUMBER - initialize the project with NUMBER sensors (defaults to 1)
- --esp32 - creates an ESP32-based project (default)
- --esp8266 - creates an ESP8266-based project

## Customization

After the project is generated you'll need to edit several files.

### platformio.ini

1. set the correct `board` name
2. change the upload speed if the default is not appropriate for your board
3. add any libraries to `lib_deps`
4. remove `-DUSE_DIAGNOSTICS` from `build_flags` if you would prefer not to link in the diagnostics library. This will save some space at the cost of some debugging flexibility.

### src/config.h

1. define the SSID and password for up to 3 wifi networks
2. change `UPDATE_INTERVAL` if you want to post updates at some interval other than one per minute
3. remove `#define VERBOSE` to get rid of some debugging messages, saving some storage
4. set `HOMEBUS_AUTHENTICATION_TOKEN` to a Homebus provisioning token appropriate for this project
5. set `HOMEBUS_SERVER` to the name of the Homebus provisioning server that manages the network this device will join

### NAME.h

This file's name will be the name you gave the project.

1. add definitions for any DDCs this project publishes

### NAME.cpp

This file's name will be the name you gave the project.

1. replace the `#include <sensor0.h>` and similar lines with includes for the library files for the actual sensors you're using
2. replace `Sensor0 sensor0;` and similar lines with definitions for the sensors your actually using
3. replace the lines with `sensor0.begin()` and similar lines with initialization calls for the sensors you're using
4. add any DDCs that this device publishes to the `publishes[]` array
5. rewrite `sensor0_update()` and similar functions to create the updates that each sensor will publish. The function should return `false` if the sensor isn't available or present or isn't ready to publish new data
6. In `loop()`, change `sensor0.loop()` and similar functions to call the loop handlers for each sensor. Omit any that do not have loop handlers
7. rewrite `if(sensor0_update(...))` and similar lines to call the update functions for each sensor.

## Building

You'll need [PlatformIO](https://platformio.org) installed on your system.

In the project's top level directory (with `platformio.ini` in it), run:
```
platformio run
```

to build the project or 
```
platformio run -t upload && platformio device monitor
```

to build the project, upload it to a connected device and if these steps were successful, start a serial monitor to display the device's output.

## License

This project is licensed under the [MIT License](https://romkey.mit-license.org).
