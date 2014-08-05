TorQML
======

TorQML is a 3D visualization toolkit for numerical simulations.
It provides an architecture for describing 3D structures in Qt Quick QML and enables you to animate the models with numerical data.

TorQML is now under development.
Stable release will be out after the official release of Qt3D (in Qt 5.5).

## Features

* User-friendly QML language for modelling
* TorQML Viewer application for quick preview and exporting
* Frame capture to PNG sequence
* Extensibility with Ruby, QML with Javascript, and C++, thanks to [ruby-qml](https://github.com/seanchas116/ruby-qml/)

## Gallery
![Gallery](https://github.com/tokoro10g/torqml/wiki/img/wheeled_vehicle.png)
![Gallery](https://github.com/tokoro10g/torqml/wiki/img/quad_pendulum.png)
![Gallery](https://github.com/tokoro10g/torqml/wiki/img/furuta_pendulum.png)

## Installation

### Requirements

* Git
* Qt 5.2 or later
* Qt3D for Qt 5
* Ruby 2.0.0 or later
* [ruby-qml](https://github.com/seanchas116/ruby-qml/) \>= 1.0.0 and its dependencies

Tested on Arch Linux, Ubuntu 14.04 LTS.
Not supporting Windows.

### Linux

#### Install Dependencies

* Install Qt 5, Ruby and git
* Install ruby-qml (install its dependencies beforehand)

    ```sh
    $ gem install qml
    ```

* Install Qt3D
    * Ubuntu 14.04

        ```sh
        $ sudo apt-get install qtdeclarative5-qt3d-plugin
        ```

    * Manual Build (for Qt 5.3 or later)

        ```sh
        $ git clone https://gitorious.org/qt/qt3d.git
        $ cd qt3d
        $ git checkout bdb98ba
        $ qmake && make && make docs
        $ sudo make install
        $ sudo make install-docs
        ```

        Installing documentations is recommended.

* Install build dependencies (for development)

   ```sh
   $ bundle install
   ```

#### Install TorQML

```sh
$ gem install torqml
```

You can also build the latest version by yourself.

```sh
$ git clone https://github.com/tokoro10g/torqml.git
$ cd torqml
$ rake install
```

### OS X

TODO: write docs for OS X

## Documentations

See [wiki](https://github.com/tokoro10g/torqml/wiki) for further information.

### Writing Model Structure

Using TorQML, you can define your model in JSON-like language, QML.
Models are composed of shapes (e.g. Box, Cylinder, etc.) and transformations.
Linked structures are expressed by nested structures.

``` qml
TQModel {
   TQBox { // 1st link
      xLength: 0.5; yWidth: 0.3; zDepth: 0.3
      TQBox { // 2nd link
         xLength: 1.0; yWidth: 0.3; zDepth: 0.3
         color: "blue"
         transform: [ Rotation3D { angle: 30; axis: "0,0,1" } ]
         TQBox { // 3rd link
            xLength: 0.5; yWidth: 0.3; zDepth: 0.3
            color: "green"
            transform: [ Rotation3D { angle: 30; axis: "0,0,1" } ]
         }
      }
   }
}
```

### Visualize Data

You can import numerical data from MATLAB Mat-File and CSV / TSV / SSV to create animations for your models.

![Visualization](https://github.com/tokoro10g/torqml/wiki/img/viewer_main.png)

The animations are ready for exporting to the handy PNG image files.

### Extending TorQML

TorQML also offers an extensible, yet simple plugin system.
You can write your plugin in QML, Ruby, C++, and Javascript for your own advanced project, and for the community as well.

## Future Works

* Introduce data pipe from external simulation applications (e.g. MATLAB, Octave, etc.)
* Implement mp4 capture mode
* Design the interface for dynamic model parameter editing
* Provide an example of running a simulation inside TorQML
* Wait for a stable release of Qt3D (in near future), then write tests

## Contributing

Contributing and issue reporting to TorQML ( https://github.com/tokoro10g/torqml ) are welcome.

You should follow these steps :

1. Install dependencies
1. Fork on GitHub
1. Edit, and commit the changes into new branch
1. Push, and create a pull-request via GitHub
