# Gio

A simple country lookup for IP addresses using CSV files such as the MaxMind free database.  

```sh
curl http://data-services.c8online.com:3000/api/addresses -X POST -d '{"ip_address": "195.171.93.18"}' -H 'Content-Type: application/json'
```

## Deployment details

The app is very simply installed onto data-services.c8online.com and listens on port 3000 (so `ufw` and the Brightbox firewall both have that port opened).  

The files are in `/home/app/gio` and the `docker-compose.yml` is used to build a docker image.  The database is in `/home/app/gio/data`.  

Then a systemd service has been configured to ensure the app stays running.  This is in `/etc/systemd/system/gio.service` and looks like this: 

```
[Unit]
Description=Gio
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=/home/app/gio
Restart=always
ExecStart=/usr/bin/docker-compose up
ExecStop=/usr/bin/docker-compose down

[Install]
WantedBy=multi-user.target
```

Use `sudo systemctl daemon-reload` to ensure systemd knows about the service, then `sudo service gio start` to start the service.  

There is a deploy script in the bin folder that simply copies the current code to the server, stops the service, uses `docker-compose` to rebuild the image and run migrations, then restarts the service.  

Nothing fancy but it does the job.  

Ideally we'd stick HTTPS over the front-end but there's nothing secure going on here.  