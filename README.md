# Total Commander Cookbook
This Chef cookbook installs [Total Commander](http://ghisler.com), a shareware file manager for Windows.

# Requirements

* Windows
* The `7-zip` cookbook.

# Usage

Set the `node['totalcmd']['source']` attribute to the location of the Total Commander installation file, and add `totalcmd` to your runlist.

# Attributes

## Required
* `node['totalcmd']['source']` - Required, location of the Total Commander installation file, e.g. `\\server\install\tcm851ax32_64.exe`.

## Optional
* `node['totalcmd']['bitness']` - Which Total Commander version should be installed? `:i386` for 32-bit, `:x86_64` for 64-bit, or `:auto` for autodetection (32-bit on 32-bit Windows, 64-bit on 64-bit Windows). Defaults to `:auto`.
* `node['totalcmd']['checksum']` - SHA256 checksum of the installation file. Defaults to the checksum of the official `tcm851ax32_64.exe`.
* `node['totalcmd']['install_dir']` - The directory where Total Commander should be installed to. Defaults to `c:\totalcmd`.
* `node['totalcmd']['registration_key']` - If set, should contain a fully qualified URL pointing to the registration key file for Total Commander, e.g. `http://www.example.com/wincmd.key`.

# Recipes

## default
Installs Total Commander, possibly including the registration key.

# Author

Author:: Petr Kadlec (mormegil@centrum.cz)
