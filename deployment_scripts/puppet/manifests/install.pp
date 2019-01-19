if roles_include(['compute']){
    package {'fuel-plugin-nova-docker':
      ensure  => 'installed',
    } ->
    package {'docker.io':
      ensure  => 'installed',
    } ->
    exec {'add nova to docker group':
      command => 'usermod -aG docker nova',
      path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    } ->
    exec {'verify docker installation':
      command => 'su nova -c docker ps',
      path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    }
}
