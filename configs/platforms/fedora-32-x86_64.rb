platform "fedora-32-x86_64" do |plat|
  # If we're using a new enough Vanagon that has this method, use it
  if defined?(plat.inherit_from_default)
    plat.inherit_from_default
    packages = %w(git)
    plat.provision_with("/usr/bin/dnf install -y --best --allowerasing #{packages.join(' ')}")
    # Otherwise, fall back to the old way
  else
    plat.servicedir "/usr/lib/systemd/system"
    plat.defaultdir "/etc/sysconfig"
    plat.servicetype "systemd"

    plat.vmpooler_template "fedora-32-x86_64"
    plat.dist "fc32"

    packages = %w[
    autoconf automake bzip2-devel gcc gcc-c++
    make cmake pkgconfig readline-devel
    rpmdevtools rsync swig zlib-devel git
    ]
    plat.provision_with("/usr/bin/dnf install -y --best --allowerasing #{packages.join(' ')}")

    plat.install_build_dependencies_with "/usr/bin/dnf install -y --best --allowerasing"
  end
end
