# Class: java_service_wrapper
#
#    Manage  the installation of the java_service_wrapper
#    libraries based on your system specs
#
# Parameter:
#
#    None
#
# Actions:
#
#    Install the files to their respective path
#
# Requires:
#
#    A working java implementation
#
# Sample Usage:
#
#    include java_service_wrapper
#
# Note:
#
#    This class will normally be included from a
#    java_service_wrapper::service definition
#
class java_service_wrapper (
  $lib_dir        =    $java_service_wrapper::params::lib_dir,
  $bin_dir        =    $java_service_wrapper::params::bin_dir,
  $owner          =    $java_service_wrapper::params::owner,
  $group          =    $java_service_wrapper::params::group,
  $jsw_kernel     =    $java_service_wrapper::params::jsw_kernel,
  $jsw_arch       =    $java_service_wrapper::params::jsw_arch,
  $jsw_extension  =    $java_service_wrapper::params::jsw_extension,


) inherits java_service_wrapper::params{


  file {"${lib_dir}/wrapper.jar" :
    ensure => present,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
    source => 'puppet:///modules/java_service_wrapper/lib/wrapper.jar',
  }

  file {"${lib_dir}/libwrapper${jsw_extension}":
    ensure => present,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/lib/libwrapper-${jsw_kernel}-${jsw_arch}${jsw_extension}",
  }

  file {"${bin_dir}/wrapper" :
    ensure => present,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
    source => "puppet:///modules/java_service_wrapper/bin/wrapper-${jsw_kernel}-${jsw_arch}",
  }
}
