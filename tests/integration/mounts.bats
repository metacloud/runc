#!/usr/bin/env bats

load helpers

function setup() {
	teardown_busybox
	setup_busybox
}

function teardown() {
	teardown_busybox
	teardown_running_container test_bind_mount
}

@test "runc run [bind mount]" {
	update_config 	' .mounts += [{"source": ".", "destination": "/tmp/bind", "options": ["bind"]}]
			| .process.args |= ["ls", "/tmp/bind/config.json"]'

	runc run test_bind_mount
	[ "$status" -eq 0 ]
	[[ "${lines[0]}" == *'/tmp/bind/config.json'* ]]
}
