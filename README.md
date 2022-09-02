# baller

Generates a skeletal *ball ESP32 or ESP8266 project that posts sensor values to a [Homebus](https://github.com/HomeBusProjects/homebus) broker.

## Usage

```
bin/baller new NAME --mit --git --sensors # --esp32 --esp8266
```

Generates a PlatformIO project in the `NAME` directory supporting `#` sensors.

After the project is generated, edit `platformio.ini` to provide the needed libraries, 
and edit `src/NAME.cpp` to include the correct sensor library header
files and correctly initialize and use each sensor, as well as the
correct sensor DDCs.
