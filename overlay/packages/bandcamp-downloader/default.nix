{ pythonPackages }:

with pythonPackages;

let withoutCheck = pkg: (pkg.overridePythonAttrs (oldAttrs: {
  doCheck = false;
  checkPhase = ''
    nosetests
  '';
})); in

let demjson = buildPythonPackage rec {
  pname = "demjson";
  version = "2.2.4";
  src = fetchPypi {
    inherit pname version;
    sha256 = "0ygbddpnvp5lby6mr5kz60la3hkvwwzv3wwb3z0w9ngxl0w21pii";
  };
  propagatedBuildInputs = [
    six
  ];
  doCheck = false;
}; in

let unicode-slugify = buildPythonPackage rec {
  pname = "unicode-slugify";
  version = "0.1.3";
  src = fetchPypi {
    inherit pname version;
    sha256 = "0l7nphfdq9rgiczbl8n3mra9gx7pxap0xz540pkyz034zbz3mkrl";
  };
  propagatedBuildInputs = [
    six
    unidecode
    mutagen
  ];
  doCheck = false;
}; in

withoutCheck (buildPythonApplication rec {
  pname = "bandcamp-downloader";
  version = "0.0.8.post12";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1f8wh1xj36dhfss4ff01zi3cs3cq9k1pp01m65dg28bjq9mlgqcf";
  };

  propagatedBuildInputs = (map withoutCheck [
    demjson
  ]) ++ [
    beautifulsoup4
    docopt
    chardet
    requests
    attrs
    unicode-slugify
    mock
  ];

})
