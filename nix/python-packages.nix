pkgs : self : super : {
  graphite_web = self.graphite_web.overrideDerivation (oldAttrs: {
    preConfigure = ''
      echo "TIME_ZONE = 'Europe/Amsterdam'" > webapp/graphite/local_settings.py
    '' + oldAttrs.preConfigure;
  });

  smbus = self.buildPythonPackage (rec {
    name = "smbus-cffi-0.5.1";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/29/3d/a50bd997979c7554c9c571753d34e976eb88ebf41d3a66accb2468bd3c69/smbus-cffi-0.5.1.tar.gz";
      md5 = "f621c871bd658ee665751ad78e3b2df9";
    };

    buildInputs = [self.cffi];

    meta = {
      description = "This Python module allows SMBus access through the I2C /dev interface on Linux hosts. The host kernel must have I2C support, I2C device interface support, and a bus adapter driver.";
      homepage = https://pypi.python.org/pypi/smbus-cffi;
      license = pkgs.licenses.gpl2;
      maintainers = [];
    };
  });

  cherrypy = self.buildPythonPackage (rec {
    name = "cherrypy-${version}";
    version = "3.6.0";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/C/CherryPy/CherryPy-${version}.tar.gz";
      sha256 = "a149271819a15417104aa8f641ad5b96287070f0153e6ef2832a87e2c693d75d";
    };

    doCheck = false;

    meta = {
      homepage = "http://www.cherrypy.org";
      description = "A pythonic, object-oriented HTTP framework";
    };
  });

  graphitesend = let pkgName = "graphitesend";
                 in self.buildPythonPackage (rec {
    name = "${pkgName}-${version}";
    version = "0.3.4";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/g/${pkgName}/${name}.tar.gz";
      sha256 = "9f48ae2d6574b425629420245068ef95b80ab434f95a866c010446b220b99ba1";
    };

    doCheck = false;

    meta = {
      homepage = "https://pypi.python.org/pypi/${pkgName}";
      description = "A simple interface for sending metrics to Graphite";
    };
  });

  PySensors = let pkgName = "PySensors";
                  libsensors = "${pkgs.lm_sensors}/lib/libsensors.so";
                  sensorsConf = "${pkgs.lm_sensors}/etc/sensors3.conf";
              in self.buildPythonPackage (rec {
    name = "${pkgName}-${version}";
    version = "0.0.3";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/P/${pkgName}/${name}.tar.gz";
      sha256 = "b735dada5318ce50f2d141d29b102e7a116a5934509583f86302d4b59399e961";
    };

    patchPhase = ''
      sed "s|os\.environ\.get('SENSORS_LIB') or find_library('sensors')|'${libsensors}'|" -i sensors/__init__.py
      sed "s|/etc/sensors3.conf|${sensorsConf}|" -i sensors/__init__.py
    '';

    doCheck = false;

    meta = {
      homepage = "http://pypi.python.org/pypi/PySensors/";
      description = "Python bindings to libsensors";
    };
  });

  mandrill = let pkgName = "mandrill";
             in self.buildPythonPackage (rec {
    name = "${pkgName}-${version}";
    version = "1.0.57";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/m/${pkgName}/${pkgName}-${version}.tar.gz";
      sha256 = "1b5p27cndnz19wnbwilbndyag18nlgbl3yyilcx5j7j84s4lnrk9";
    };

    doCheck = false;

    buildInputs = [ self.docopt_040 ];

    propagatedBuildInputs = [ pkgs.pythonPackages.requests ];

    meta = {
      homepage = "https://mandrillapp.com/api/docs/index.python.html";
      description = "A CLI client and Python API library for the Mandrill email as a service platform";
    };
  });

  docopt_040 = self.buildPythonPackage rec {
    name = "docopt-0.4.0";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/source/d/docopt/${name}.tar.gz";
      sha256 = "0xg4i2g26y8zsngq8fny1fnm5qsjldcagibp6szbg07250i5hlmp";
    };

    meta = {
      description = "Pythonic argument parser, that will make you smile";
      homepage = http://docopt.org/;
    };
  };

  sdnotify = self.buildPythonPackage rec {
    name = "sdnotify-0.3.1";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/57/f9/ae03e3ebc83be0d501cde1f5d6d23dee74f5c2105f2cdb98bff4fa9ada9c/sdnotify-0.3.1.tar.gz";
      sha256 = "0nidzwnix9xxdw2wnzg4zlri1x8cm18974izyhq23c6byva214p6";
    };

    meta = {
      description = "systemd Service Notification";
      homepage = "https://pypi.python.org/pypi/sdnotify";
    };
  };
}
