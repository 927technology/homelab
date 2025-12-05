# curl -s -k -X GET "https://192.168.1.150:8006/api2/json/cluster/resources?type=vm" \
#      -H "Authorization: PVEAPIToken=svc_api@pve!api=c7d9f2a8-ce86-4ae1-a51b-f187efe43db2"   

# curl -s -k -d 'username=svc_api@pve' --data-urlencode 'password=1qaz2wsx!QAZ@WSX' https://192.168.1.150:8006/api2/json/access/ticket

cmd_curl=/bin/curl
_host=192.168.1.150
_host_port=8006
_api_user=svc_api
_api_user_realm=pve
_api_key_name=api
_api_key_value=c7d9f2a8-ce86-4ae1-a51b-f187efe43db2

case ${1} in
  cluster/status    ) _path="cluster/status"                  ;;
  firewall/rules    ) _path="cluster/firewall/rules"          ;;
  list/nodes        ) _path="cluster/resources?type=node"     ;;
  list/resources    ) _path="cluster/resources"               ;;
  list/sdns         ) _path="cluster/resources?type=sdn"      ;;
  list/storages     ) _path="cluster/resources?type=storage"  ;;
  list/vms          ) _path="cluster/resources?type=vm"       ;;
esac

${cmd_curl}       \
  -s              \
  -k              \
  -X GET "https://${_host}:${_host_port}/api2/json/${_path}" \
  -H "Authorization: PVEAPIToken=${_api_user}@${_api_user_realm}!${_api_key_name}=${_api_key_value}"   
