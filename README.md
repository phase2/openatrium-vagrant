# An OpenAtrium.com Vagrant

Steps to get Vagranting:

- Put a Drupal 6 (or theoretically 7) site in this directoery in a folder called `openatrium.com`
- `cd vagrant`
- `vagrant up`
- Enter your root password for NFS _before_ you get coffee.
  - Go get coffee.
- Add `172.31.31.44 local.openatrium.com` to your host machine's /etc/hosts
- Wait until the `vagrant up` finishes.
- Hit http://local.openatrium.com in your browser.
  - If you need to install Drupal, there's a db called `openatrium` with user/pass of `openatrium`
- PROFIT!
