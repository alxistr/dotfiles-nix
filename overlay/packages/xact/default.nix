{ pythonPackages }:

with pythonPackages;
buildPythonApplication rec {
  pname = "xact";
  version = "0.0.1";

  src = fetchGit {
    url = "https://github.com/xoreaxebx/xact.git";
    rev = "e18656c0fcc98175431a46b4e353173031fd79fd";
  };

  propagatedBuildInputs = [
    ewmh
    pynput
    psutil
  ];

}
