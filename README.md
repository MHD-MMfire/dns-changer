# dns-changer
Change dns settings using batch file

## Usage
1. open `dns.bat` in an editor (right click => edit)
2. change the second line from `set interface=Ethernet` to `set interface=X` where `X` is your adaptor interface name

note: to know your interface name, open cmd and type `ipconfig /all` and find the proper interface name to use (e.g. Local Area Network)