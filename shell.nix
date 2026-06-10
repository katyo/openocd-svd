{ pkgs ? import <nixpkgs> {
  overlays = [ (import /home/kayo/devel/nixos-addons/packages) ];
} }:
with pkgs;
let qtenv = qt5.env "myenv" (with qt5; [
      qtbase
    ]);
    qtver = qt5.qtbase.version;
    qtpfx = "${qtenv}/lib/qt-${qtver}";
in mkShell {
  buildInputs = [
    (python312.withPackages (pypkgs: with pypkgs; [
      cmsis-svd-ng
      pyqt5
      #telnetlib3
    ]))
  ];
  shellHook = ''
    export QT_PLUGIN_PATH="${qtpfx}/plugins"
    export QML_IMPORT_PATH="${qtpfx}/qml"
    export QT_QPA_PLATFORM_PLUGIN_PATH="${qtpfx}/plugins/platforms"
  '';
}
