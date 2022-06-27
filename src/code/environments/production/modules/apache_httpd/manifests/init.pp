class webserver {
  
  package {'httpd': 
    ensure => present
  }
}
