Copyright: (c) 2021, Cisco Systems

# Crosswork 4.0 Components (CDG) Installer <img align="right" width="50" height="50" src="https://wwwin-github.cisco.com/weigang/CW-4.0-Automation/blob/master/media/logo.png">

Crosswork 4.0 comes with several components, with CDG as one of the main components. The deployment of the ova components involves entering parameters manually through VMware vCenter portal with large set of parameters. In addition, to provide HA and scale solution, it often needs to setup multiple instances. For example, one deployment use case requires deploying up to eight CDG (Crosswork Data Gateway) instances, each needs up to thirty parameters across multiple vCVcenter screens. The manual approach is not scalable, error prone and can result un-predictable deployment outcomes. 

The Ansible playbooks were developed by the TTG C-SDN team to automate the deployment Crosswork components. The purpose is to accelerate Crosswork solution rollout for internal lab, customer PoC, and production environments.

This tool is designed for ***Cisco personnel*** use only. The source code should not be shared with 3rd parties. The playbook can be run from any host with Ansible 2.6 or higher.

Extensibility
----
This tool is designed with modular Ansible plays with extensibility for any ova based deployment scales to multiple instances. CDG installer can be the first reference implementation. Other sample reference implementation will be added in the near future. 

Prerequisites
----

* The user account using the installer have access to vCenter for target CDG instances with VM creation and configuration privileges. 
* The cdg installer assmums Crosswork 4.0 infra is deployed.

Package Structure
----
The directory structure of the package:

```
.
├── LICENSE.md
├── README.md
├── group_vars
│   ├── local.yml
│   └── sample.yml
├── hosts
├── install-cnc.yml
├── roles
│   └── cdg-install
│       ├── defaults
│       ├── tasks
│       ├── templates
│       └── tests
└── vars
```

1. `group_vars` contain host group variables. `local.yml` is the variable file for the installer. The file is encrypted by `ansible-vaule`. A sample variable file `sample` can be used as an example.
2. `hosts` is the inventory file
3. `install-cnc.yml` is the main player. It currently invokes plays for CDG install.
4. `roles` is the directory for all ova deployments. Currently, it contains one role `cdg-install`


Usage
----
1. Install `ovftool`
2. Install `ansible`
3. Prepare varriables

	a. Edit `group_vars/sample.yml` ( [sample.yml](https://wwwin-github.cisco.com/weigang/CW-4.0-Automation/blob/master/vm-install/group_vars/sample.yml) ), replacing access credentials, save it as `group_vars/local.yml`. 
	
	Note, since `local.yml` contains sensitive information, it is recommended to use `ansible-vault` to encrypt.
	
	Example:
	
	```
	weigang@WEIGANG-M-27CE vm-install % ansible-vault encrypt group_vars/local.yml
	Vault password: 
	Confirm Vault password:
	```
	
	b. File `roles/cdg-install/default/main.yml`  defines CDG VM variables. It contains a `list` of CDG instance parameters in `dict` structure. Edit the file with the parameters that fits your deployment. Repeat the `list` element to align with the number of CDG instances you need to deploy. File `main.yml` ( [default/main.yml](https://wwwin-github.cisco.com/weigang/CW-4.0-Automation/blob/master/vm-install/roles/cdg-install/defaults/main.yml) ) with the package contains an example to deploy three CDG instances.
	
4. Run the playbook to deploy. From `vm-install`, run the follow:

	```
	ansible-playbook -i hosts vm-install.yml
	```
	Note, if you have encrypted `group_vars/local.yml` for protection, you need to decrypt.
	
	Example:
	
	```
	weigang@WEIGANG-M-27CE vm-install % ansible-vault decrypt group_vars/local.yml
   Vault password: 
   Decryption successful
   ```
	
5. Post installation check

	a. During installation, you can monitor the VM creation progress from vCenter dashboard
	
	b. After all CDG VM's are created successfully, check Crosswork->Administratiom->Data Gateway Management -> Virtual Machines to make sure they are all operational	
	

Authors
----
  
**Sanka Chen** - Cisco CX TTG (Technology Transformation Group)  
**Pablo Bonilla** - Cisco CX TTG (Technology Transformation Group)  
**Weigang Huang** - Cisco CX TTG (Technology Transformation Group)  

Revision History
----

Release v1.0 - May 3, 2021
* Initial release with CDG installer

References
----

[Cisco Crosswork Infrastructure 4.0 and Applications Installation Guide](https://www.cisco.com/c/en/us/td/docs/cloud-systems-management/crosswork-infrastructure/4-0/InstallGuide/b_cisco_crosswork_platform_40_and_applications_install_guide/m_plan-your-installation.html)


License
----

This project is [Licensed](https://wwwin-github.cisco.com/weigang/CW-4.0-Automation/blob/master/vm-install/LICENSE.md)



