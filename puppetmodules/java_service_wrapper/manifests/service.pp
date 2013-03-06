# Define: java_service_wrapper::service
#
#   Set a java service as a daemon using java_service_wrapper
#
# Parameters:
#
#    [*run_as_user*]        : The user the service will be run as
#    [*base_path*]          : The location were files will be installed
#    [*app_name*]           : The application name
#    [*app_long_name*]      : The application long name - if any
#    [*wrapper_cmd*]        : The path to the wrapper binary
#    [*wrapper_conf*]       : The path to the wrapper configuration file
#    [*piddir*]             : The path to the pid file
#    [*user_upstart*]       : Boolean to specify is upstart will be used
#    [*wrapper_java_cmd*]   : The path to the java binary
#    [*wrapper_logfile*]    : The path to the wrapper logfile
#    [*wrapper_classpath*]  : Array of paths to classpaths
#    [*wrapper_mainclass*]  : Name of the wrapper main class : WrapperSimpleApp, WrapperJarApp, WrapperStartStopApp
#    [*wrapper_library*]    : Array of paths to libraroes
#    [*wrapper_additional*] : Array of JVM configuration flag
#    [*wrapper_parameter*]  : Array of parameters the application will take as input
#
# Actions:
#
#    It will install the java_service_wrapper component if not yet installed
#    It will configure the service_wrapper initd scriot and the service_wrapper.conf
#    on which java_service_wrapper will rely on for its configuration
#
# Requires :
#
#    A working java implementation
#
# Sample usage :
#
#    java_service_wrapper::service{'logstash' :
#         run_as_user => 'logstash',
#         app_name    => 'logstash',
#         wrapper_classpasth => ['/usr/local/lib/wrapper.jar', '/usr/local/bin/logstash.jar'],
#         wrapper_library => ['/usr/local/lib'],
#         wrapper_classpasth => ['/usr/local/bin/logstash.jar', 'agent', '-f', '/etc/logstash.d/test.conf']
#    }
#
#
class java_service_wrapper::service(
  $manage_service     = 'false',
  $owner              = 'root',
  $group              = 'root',
  $base_path          = "/usr/local",
  $lib_dir            = "${base_path}/lib" ,
  $bin_dir            = "${base_path}/bin",
  $conf_dir           = "${base_path}/conf",
  $log_dir            = "${base_path}/log",
  $app_name           = "",
  $app_long_name      = $app_name,
  $wrapper_cmd        = './wrapper',
  $wrapper_conf       = "${conf_dir}/${app_name}.conf",
  $piddir             = "${bin_dir}",
  $use_upstart        = false,
  $wrapper_java_cmd   = "${bin_dir}/jdk17/bin/java",
  $wrapper_logfile    = "${log_dir}/${app_name}.log",
  $wrapper_classpath  = [''],
  $wrapper_mainclass  = 'WrapperSimpleApp',
  $wrapper_library    = [''],
  $wrapper_additional = [''],
  $wrapper_parameter  = [''],
) {

  class {"java_service_wrapper":
      lib_dir => $lib_dir,
      bin_dir => $bin_dir,
      owner   => $owner,
      group   => $group,
  }

  file {"${bin_dir}/${app_name}.sh":
    ensure  => 'present',
    owner   => $owner,
    group   => $group,
    mode    => '0755',
    content => template("java_service_wrapper/sh.script.in"),
    require => Class["java_service_wrapper"],
  }

  file {"${wrapper_logfile}":
    ensure => 'present',
    owner   => $owner,
    group   => $group,
    mode   => '0640',
    require => Class["java_service_wrapper"],
  }

  file {$wrapper_conf :
    ensure  => 'present',
    owner   => $owner,
    group   => $group,
    mode    => '0640',
    content => template("java_service_wrapper/wrapper.conf"),
    require => Class["java_service_wrapper"],
  }
  if $manage_service == 'true' {
    file {"/etc/init.d/${app_name}" :
      ensure  => 'link',
      owner   => $owner,
      group   => $group,
      mode    => '0755',
      target  => "${bin_dir}/${app_name}.sh",
      require => Class["java_service_wrapper"],
    }

    service {$app_name:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,

    }
   }
}
