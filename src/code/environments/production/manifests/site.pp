node client {

  $essential_pkgs = ['htop']

	package { $essential_pkgs:
		ensure => installed,
	}

  file {'root_ssh_files':
    path => '/root/.ssh',
	  ensure => 'directory',
	  mode => '0700'
  }

 file {'auth_keys':
    path => '/root/.ssh/authorized_keys',
	  ensure => present,
	  mode => '0600',
	  source => 'puppet:///modules/base_conf/ssh/authorized_keys',
  }

}
