#
# Author:: Petr Kadlec (<mormegil@centrum.cz>)
# Cookbook Name:: totalcmd
# Attribute:: default
#
# Copyright 2014, Petr Kadlec.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# You must set this to the location of the installation exe
# default['totalcmd']['source'] = "...tcm801x32_64.exe"

# SHA-256 checksum of the above installation exe file
default['totalcmd']['checksum'] = "2f41d77dcc6cb87b2659101f433d2b966996ba57643fcb20c947e753665c067f"

# One of :auto, :i386, :x86_64
default['totalcmd']['bitness'] = :auto

# The destination installation directory
default['totalcmd']['install_dir'] = "c:\\totalcmd"

# The location of the registration key file, if available
# default['totalcmd']['registration_key'] = "...totalcmd.key"
