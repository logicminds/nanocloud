notify{"Setup Server Type: $::type": }
   case $::type{
	'web': {include roles::nginx}
	'tomcat': { include roles::tomcat}
	'apache': { include roles::apache}
	'dev_aio': { include roles::aio}
	default: {include roles::default}
    }


