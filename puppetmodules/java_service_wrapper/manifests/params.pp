class java_service_wrapper::params{
    $lib_dir  = "/usr/local/lib"
    $bin_dir  = "/usr/local/bin"
    $owner    =  "root"
    $group    =  "root"


    case $::kernel{
        /FreeBSD|Linux|HP\-UX|sunos/: {$jsw_extension = ".so" }
        'Darwin': {$jsw_extension = ".jnilib" }
        'AIX': {$jsw_extension = '.a' }
        default: {$jsw_extension = '.dll' }
    }
    case $::hardwaremodel{
      /(i[3456]86|pentium)/: { $jsw_arch = 'x86-32'}
      'x86_64': {$jsw_arch = 'x86-64'}

    }
    case $::kernel{
      'sunos': {$jsw_kernel = 'solaris'}
      'Darwin': {$jsw_kernel = 'macosx'}
      'HP-UX':  {$jsw_kernel = 'hpux'}
      'AIX':    {$jsw_kernel = 'aix'}
      'FreeBSD': {$jsw_kernel = 'freebsd'}
      'Linux': {$jsw_kernel = 'linux'}
      default: {$jsw_kernel = $::kernel}
    }
}
