name             'totalcmd'
maintainer       'Petr Kadlec'
maintainer_email 'mormegil@centrum.cz'
license          'Apache 2.0'
description      'Installs Total Commander'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version (ENV['BUILD_NUMBER'] ? "0.0.#{ENV['BUILD_NUMBER']}" : '0.1.0')
depends          'windows'
depends          '7-zip'
