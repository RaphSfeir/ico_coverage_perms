import sys,uuid

print sys.argv

OPT = {
        "KONG_ADMIN_ADDR":      sys.argv[1],
        "SERVICE_NAME":             sys.argv[2],
        "API_NAME":                     sys.argv[2],
        "CLIENT_ID":                    sys.argv[2],
        "CLIENT_SECRET":            sys.argv[8],
        "ADMIN_ID":                     "admin",
        "ADMIN_ACCESS_TOKEN":   sys.argv[5],
        "ADMIN_REFRESH_TOKEN":  str(uuid.uuid4()),
        "PROVISION_KEY":            "6g21adb99b8c41789ed955d421682cc7",
        "REQUEST_PATH":             sys.argv[6],
        "DATA_CENTER":              sys.argv[3],
        "STATIC_PORT":              sys.argv[4],
        "OAUTH2_SCOPES":            sys.argv[7]
        }


import json,requests

print "DELETE API #############################################################"
delete_api_url = "http://%(KONG_ADMIN_ADDR)s/apis/%(API_NAME)s/" % OPT
request = requests.delete(delete_api_url)
print request.status_code
print request.text

print "ADD API #############################################################"
add_api_url = "http://%(KONG_ADMIN_ADDR)s/apis/" % OPT
add_api_data = {
        "name":OPT["API_NAME"],
        "upstream_url":"http://%(SERVICE_NAME)s.service.%(DATA_CENTER)s.consul:%(STATIC_PORT)s" % OPT,
        "request_path":OPT["REQUEST_PATH"],
        "strip_request_path":True
        }
request = requests.post(add_api_url, data=add_api_data)
print request.status_code
print request.text

