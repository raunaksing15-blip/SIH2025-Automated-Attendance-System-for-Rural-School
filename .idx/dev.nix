{pkgs}: {
  channel = "stable-24.05";
  packages = [
    pkgs.jdk17
    pkgs.unzip
    (pkgs.python312.withPackages (ps: [
      ps.flask
      ps.flask-cors
      ps.firebase-admin
      ps.python-dotenv
      ps.gunicorn
      ps.qrcode
      ps.pillow
    ]))
    pkgs.gcc
  ];
  idx.extensions = [];
  idx.previews = {
    previews = {
      web = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname"
          "0.0.0.0"
          "--web-port"
          "$PORT"
        ];
        manager = "flutter";
      };
      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "localhost:5555"
        ];
        manager = "flutter";
      };
      backend = {
        command = [
          "python3"
          "-u"
          "backend/attendance_backend_firebase/app.py"
        ];
        manager = "web";
      };
    };
  };
}
