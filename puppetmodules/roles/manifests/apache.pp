class roles::apache{
	notify{"Apache Profile Config":}
	include roles::default
	include apacheprofile
}
