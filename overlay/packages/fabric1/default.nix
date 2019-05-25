{ pythonPackages }:

with pythonPackages;

buildPythonApplication rec {
  pname = "Fabric";
  version = "1.14.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1a3ndlpdw6bhn8fcw1jgznl117a8pnr84az9rb5fwnrypf1ph2b6";
  };

  propagatedBuildInputs = [
    cffi
    cryptography
    pynacl
    paramiko
    jinja2
  ];

  doCheck = false;

}
