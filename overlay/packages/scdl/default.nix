{ pythonPackages }:

with pythonPackages;
buildPythonApplication rec {
  pname = "scdl";
  version = "1.6.12";

  patches = [ ./home.patch ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "0fij1kqbcm5i6c4g7lbqrmrzw7xvhrawg71zgsvbayn7d6x5s4yg";
  };

  propagatedBuildInputs = [
    mutagen
    requests
    clint
    termcolor
    docopt
  ];

}
