#
# Author:: Petr Kadlec (<mormegil@centrum.cz>)
# Cookbook Name:: totalcmd
# Recipe:: default
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

source = node['totalcmd']['source']
checksum = node['totalcmd']['checksum']
bitness = node['totalcmd']['bitness']
install_dir = node['totalcmd']['install_dir']
registration_key = node['totalcmd']['registration_key']

# Ensure the installation source has been set by the user
raise "totalcmd source attribute must be set before running this cookbook" if source.nil?

# Evaluate installation file depending on bitness
if bitness === :auto then bitness = node['kernel']['machine'].to_sym end
install_name = case bitness.to_sym
    when :i386
        "INSTALL"
    when :x86_64
        "INSTALL64"
    else
        raise "unknown bitness #{bitness} for totalcmd"
end

totalcmd_installed = File.exists?(File.join(install_dir, 'TOTALCMD.EXE'))
seven_zip_exe = File.join(node['7-zip']['home'], '7z.exe')

install_temp_dir = win_friendly_path(File.join(Dir.tmpdir(), 'totalcmd'))
registration_key_path = File.join(install_dir, 'wincmd.key')

# Download installation exe to local file cache, or just use if local path
local_install_file = if !totalcmd_installed then cached_file(source, checksum) end

# Create the temporary directory for extracted installation files
directory :temp_dir_creation do
  path install_temp_dir
  action :create
  not_if { totalcmd_installed }
end

# Extract the installation exe
execute :extract_install_exe do
  command "#{seven_zip_exe} x -y -o\"#{install_temp_dir}\" \"#{local_install_file}\""
  not_if { totalcmd_installed }
end

# Modify the installation INF file and install
powershell_script :modify_inf_and_install do
  cwd install_temp_dir
  code <<-EOH
  (Get-Content #{install_name}.INF) | ForEach-Object { $_ -replace "^auto=0$", "auto=1" -replace "^Dir=c:\\totalcmd$", "Dir=#{install_dir}" } | Set-Content #{install_name}.INF
  & .\\#{install_name}.EXE
  EOH
  not_if { totalcmd_installed }
end

# Remove the temporary directory
directory :temp_dir_removal do
  action :delete
  recursive true
  not_if { totalcmd_installed }
end

# Use the registration key, if available
remote_file :wincmd_key do
  path registration_key_path
  source registration_key
  action :create_if_missing
  not_if registration_key.nil?
end
