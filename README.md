# Apache2 Reverse Proxy Box

Setup of 3 ubuntu vagrant boxes to play around with the [Apache2 Reverse Proxy Guide](https://httpd.apache.org/docs/2.4/howto/reverse_proxy.html).

![implementation](https://httpd.apache.org/docs/2.4/images/reverse-proxy-arch.png)

## Additional Goals

**Multiple Vagrant Machines**

This setup makes use of vagrants ability to spawn several machines at once via its configuration. Take a look at the
[Vagrantfile](Vagrantfile). It is self explanatory.

**Apache2 Authentication via MySql Database Storage**

We make use of a `mod-authn-dbd` and `libaprutil1-dbd-mysql` to validate against a mysql database user storage.

**Apache2 HTML Auth Form**

While authenticating via apache we do not want to use the browser specific basic buth box. Instead we want to use a
html form that we can style as desired.

## Setup

### Machines

Maybe you have to modify CPU/RAM usage in [Vagrantfile](Vagrantfile).

    Hostname    Ip              Url                CPUs         RAM                    Box Source
    ---------------------------------------------------------------------------------------------
    entry       192.168.1.122   http://entry.dev    1       2048 MB     Official Ubuntu 16.04 LTS
    app         192.168.1.123   http://app.dev      1       2048 MB     Official Ubuntu 16.04 LTS
    maria       192.168.1.124   -                   1       2048 MB     Official Ubuntu 16.04 LTS

Those machines are configured using static ip addresses. This makes routing bewtween entry, app and your localhost much
easier. Especially as we have to deal with routing specific things its always a big deal to be able to "fix" ip addresses
instead of getting weird network setups.

Best idea is you also configure your local `hosts` file accordingly:

    192.168.1.122       entry entry.dev www.entry.dev
    192.168.1.123       app app.dev www.app.dev
    192.168.1.124       maria maria.dev
    
If you want change ips you need to modify those files:

 + [app/provision.sh](app/provision.sh)
 + [entry/provision.sh](entry/provision.sh)
 + [maria/provision.sh](maria/provision.sh)
 + [Vagrantfile](Vagrantfile)

### Web Application Credentials

    Username:   test
    Password:   test

### MariaDB

    Username:   root
    Password:   root

## Vagrant Up

Short Version: Visit [http://entry.dev](http://entry.dev), click on link and login.

Your browsers url should show, that you are still on the same domain under `http://entry.dev/app`, but the content you
get served is coming from `http://app.dev/index.html`.

Normally the entry server is available via its public ip. The app under `/app` must not be available via public ip, but
can be reached by the entry server via private network.

The auth has been initialized by the entry server and not by the app. This way web applications behind the entry server
do not have to take care about valid users. There is no need to implement authentication handling in those applications.
Authorization still has to be done by the app.

## Sources

 + [Apache2 Reverse Proxy](https://httpd.apache.org/docs/2.4/howto/reverse_proxy.html)
 + [Apache2 Mod Proxy](https://httpd.apache.org/docs/2.4/mod/mod_proxy.html)
 + [Apache2 Mod Auth Form](https://httpd.apache.org/docs/2.4/mod/mod_auth_form.html)
 + [Apache2 Mod Session Cookie](https://httpd.apache.org/docs/2.4/mod/mod_session_cookie.html)
 + [Apache2 Mod Headers](https://httpd.apache.org/docs/2.4/mod/mod_headers.html)
 + [Apache2 Mod Authn DBD](http://httpd.apache.org/docs/current/mod/mod_authn_dbd.html)
 + [Apache2 Mod Authn DBD Params](https://httpd.apache.org/docs/2.4/mod/mod_dbd.html#dbdparams)
 + [Apache2 Password Encryptions](http://httpd.apache.org/docs/current/misc/password_encryptions.html)
 + [MySql Encryption Functions](https://dev.mysql.com/doc/refman/5.5/en/encryption-functions.html)
 + [APR MySQL Driver (libaprutil1-dbd-mysql)](http://packages.ubuntu.com/de/trusty/libaprutil1-dbd-mysql)

## Nice to have

 + Implement SSL usage
 + Implement Auth Cache
 + Implement Apache2 Load Balancer
 + Implement MariaDB Galera Cluster
 
## Known Bugs

[https://bugs.launchpad.net/cloud-images/+bug/1569237](https://bugs.launchpad.net/cloud-images/+bug/1569237)

While `vagrant ssh <maschine>` works just perfect, you might not be able to ssh to one of the virtual machines directly
using username and password. This is a known bug in Canonicals official Ubuntu box. We need to reset age and password.
By the way - Ubuntu does not use the `vagrant` user. On their boxes the default vagrant user is `ubuntu`. Here the
example to fix this bug for entry server:

    vagrant ssh entry
    sudo passwd -d -u ubuntu
    sudo chage -d0 ubuntu
    exit
    vagrant ssh entry
    (You will be promped for a new password and get disconnected)
    (You are ready to ssh using credentials)

Maybe someday they get that bug fixed. Check in certain intervalls.