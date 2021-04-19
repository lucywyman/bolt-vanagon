platform "el-7-x86_64" do |plat|
  # If we're using a new enough Vanagon that has this method, use it
  if defined?(plat.inherit_from_default)
    plat.inherit_from_default
    packages = %w(git)
    plat.provision_with "yum install --assumeyes #{packages.join(' ')}"
    # Otherwise, fall back to the old way
  else
    plat.servicedir "/usr/lib/systemd/system"
    plat.defaultdir "/etc/sysconfig"
    plat.servicetype "systemd"

    plat.provision_with "rpm --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs"
    plat.add_build_repository "http://pl-build-tools.delivery.puppetlabs.net/yum/pl-build-tools-release-#{plat.get_os_name}-#{plat.get_os_version}.noarch.rpm"
    plat.provision_with "yum install --assumeyes autoconf automake rsync gcc createrepo make rpmdevtools rpm-libs yum-utils rpm-sign libtool autogen git"
    plat.install_build_dependencies_with "yum install --assumeyes"
    plat.vmpooler_template "centos-7-x86_64"
  end
end
