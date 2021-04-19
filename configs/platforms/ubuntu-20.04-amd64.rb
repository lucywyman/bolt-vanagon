platform "ubuntu-20.04-amd64" do |plat|
  # If we're using a new enough Vanagon that has this method, use it
  if defined?(plat.inherit_from_default)
    plat.inherit_from_default
    packages = %w(git)
    plat.provision_with "export DEBIAN_FRONTEND=noninteractive; apt-get update -qq; apt-get install -qy --no-install-recommends #{packages.join(' ')}"
    # Otherwise, fall back to the old way
  else
    plat.servicedir "/lib/systemd/system"
    plat.defaultdir "/etc/default"
    plat.servicetype "systemd"
    plat.codename "focal"

    plat.provision_with "curl https://enterprise.delivery.puppetlabs.net/pluto.pub.gpg | apt-key add - "
    plat.add_build_repository "http://pl-build-tools.delivery.puppetlabs.net/debian/pl-build-tools-release-#{plat.get_codename}.deb"
    plat.provision_with "export DEBIAN_FRONTEND=noninteractive; apt-get update -qq; apt-get install -qy --no-install-recommends build-essential devscripts make quilt pkg-config debhelper rsync fakeroot git"
    plat.install_build_dependencies_with "DEBIAN_FRONTEND=noninteractive; apt-get install -qy --no-install-recommends "
    plat.vmpooler_template "ubuntu-2004-x86_64"
  end
end
