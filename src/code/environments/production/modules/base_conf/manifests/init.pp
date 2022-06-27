class base_conf {
  $essential_pkgs = ['htop', 'vim', 'tree', 'lsof', 'git', 'wget', 'net-tools']

	package { $essential_pkgs:
		ensure => present,
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

  file {'bashrc':
    path => '/root/.bashrc',
	  ensure => present,
	  mode => '0644',
	  source => 'puppet:///modules/base_conf/bash/bashrc',
  }

}
