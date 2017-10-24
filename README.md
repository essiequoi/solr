# solr

Use this script to scan all of your config files for deprecated fields and/or primitive types which use docValues. 
The hardcoded field deprecations and docValues types listed in this script pertain to Solr 4.10. You can add to each array every time a field becomes deprecated.


Usage:

bash solr_4_configs_upgrade.sh [directory]
