if node["collectd"]["plugins"]
  plugins = node["collectd"]["plugins"]
  plugin_support_packages = []

  case node["platform_family"]
  when "rhel"
    include_recipe "yum-epel"

    plugin_support_packages << "ganglia-devel" if plugins.include?("ganglia")
    plugin_support_packages << "libcurl-devel" if plugins.include?("apache") ||
      plugins.include?("ascent") ||
      plugins.include?("curl") ||
      plugins.include?("nginx") ||
      plugins.include?("write_http")
    plugin_support_packages << "libesmtp-devel" if plugins.include?("notify_email")
    plugin_support_packages << "libgcrypt-devel" if plugins.include?("network")
    plugin_support_packages << "libmemcached-devel" if plugins.include?("memcached")
    plugin_support_packages << "liboping-devel" if plugins.include?("ping")
    plugin_support_packages << "libpcap-devel" if plugins.include?("dns")
    plugin_support_packages << "libvirt-devel" if plugins.include?("virt")
    plugin_support_packages << "libxml2-devel" if plugins.include?("ascent") ||
      plugins.include?("virt")
    plugin_support_packages << "mysql-devel" if plugins.include?("mysql")
    plugin_support_packages << "perl-devel" if plugins.include?("perl")
    plugin_support_packages << "postgresql-devel" if plugins.include?("postgresql")
    plugin_support_packages << "python-devel" if plugins.include?("python")
    plugin_support_packages << "hiredis" if plugins.include?("redis")
    plugin_support_packages << "rrdtool-devel" if plugins.include?("rrdcached") ||
      plugins.include?("rrdtool")
    plugin_support_packages << "varnish-libs-devel" if plugins.include?("varnish")
    plugin_support_packages << "yajl-devel" if plugins.include?("curl_json")
  when "debian"
    plugin_support_packages << "libcurl4-openssl-dev" if plugins.include?("apache") ||
      plugins.include?("ascent") ||
      plugins.include?("curl") ||
      plugins.include?("nginx") ||
      plugins.include?("write_http")
    plugin_support_packages << "libesmtp-dev" if plugins.include?("notify_email")
    plugin_support_packages << "libganglia1" if plugins.include?("ganglia")
    plugin_support_packages << "libgcrypt11-dev" if plugins.include?("network")
    plugin_support_packages << "libmemcached-dev" if plugins.include?("memcached")
    plugin_support_packages << "libmysqlclient-dev" if plugins.include?("mysql")
    plugin_support_packages << "liboping-dev" if plugins.include?("ping")
    plugin_support_packages << "libpcap0.8-dev" if plugins.include?("dns")
    plugin_support_packages << "libperl-dev" if plugins.include?("perl")
    plugin_support_packages << "python-dev" if plugins.include?("python")
    plugin_support_packages << "libhiredis-dev" if plugins.include?("redis")
    plugin_support_packages << "librrd-dev" if plugins.include?("rrdcached") ||
      plugins.include?("rrdtool")
    plugin_support_packages << "libvirt-dev" if plugins.include?("virt")
    plugin_support_packages << "libxml2-dev" if plugins.include?("ascent") ||
      plugins.include?("virt")
    plugin_support_packages << "libyajl-dev" if plugins.include?("curl_json")
  end

  plugin_support_packages.each do |pkg|
    package pkg
  end
end
