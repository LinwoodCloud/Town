Name:           linwood-setonix
Version:        1.0.0
Release:        1%{?dist}
Summary:        Play games everywhere you like
BuildArch:      %{_target_cpu}
URL:            https://github.com/LinwoodDev/Setonix
License:        AGPLv3
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
Coming soon...

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{name}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/pixmaps

# Copy binaries and architecture-specific files
cp %{name} $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R lib $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R data $RPM_BUILD_ROOT/%{_datadir}/%{name}

# Create symlink for the binary
ln -s %{_datadir}/%{name}/%{name} $RPM_BUILD_ROOT/%{_bindir}/%{name}

# Install the desktop file
desktop-file-install --dir=$RPM_BUILD_ROOT/usr/share/applications %{name}.desktop

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_datadir}/%{name}
/usr/share/applications/

%changelog
