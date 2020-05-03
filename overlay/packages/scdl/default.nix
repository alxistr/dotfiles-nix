{ pythonPackages }:

with pythonPackages;
buildPythonApplication rec {
  pname = "scdl";
  version = "1.6.12";

  patches = [ ./home.patch ];

  src = fetchGit {
    url = "https://github.com/flyingrub/scdl.git";
    rev = "b0a164f843d7d7282f4f2e742892e0239d282a91";
    # inherit pname version;
    # sha256 = "0fij1kqbcm5i6c4g7lbqrmrzw7xvhrawg71zgsvbayn7d6x5s4yg";
  };

  propagatedBuildInputs = [
    mutagen
    requests
    clint
    termcolor
    docopt
  ];

}
