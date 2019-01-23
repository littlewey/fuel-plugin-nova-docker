if roles_include(['compute']){
    nova_config {
      'default/compute_driver':     value => "novadocker.virt.docker.DockerDriver";
    } ->
    exec{"restart nova compute service":
      command => "/usr/sbin/service nova-compute restart",
    }
}

if (roles_include(['controller']) or roles_include(['primary-controller'])){
    glance_api_config {
      'default/container_formats':  value => "ami,ari,aki,bare,ovf,ova,docker";
    } ->
    exec{"restart Glance api service":
      command => "/usr/sbin/service glance-api restart",
    } ->
    exec{"restart Glance glare service":
      command => "/usr/sbin/service glance-glare restart",
    } ->
    exec{"restart Glance registry service":
      command => "/usr/sbin/service glance-registry restart",
    }
}
