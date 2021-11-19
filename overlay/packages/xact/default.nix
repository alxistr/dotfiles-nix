{ pythonPackages }:

with pythonPackages;
buildPythonApplication rec {
  pname = "xact";
  version = "0.0.1";

  src = fetchGit {
    url = "https://github.com/xoreaxebx/xact.git";
    rev = "72d97297441be7c86b2123cc4d79166ef839e3ea";
  };

  propagatedBuildInputs = [
    ewmh
    pynput
    psutil
  ];

}
