class roles::nginx{
	notify{"Web Profile Config":}
	include roles::default
	include nginxprofile
}
