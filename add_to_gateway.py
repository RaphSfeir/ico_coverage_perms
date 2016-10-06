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
        "strip_request_path":False
        }
request = requests.post(add_api_url, data=add_api_data)
print request.status_code
print request.text


print "ADD PLUGIN #############################################################"
add_plugin_url = "http://%(KONG_ADMIN_ADDR)s/apis/%(API_NAME)s/plugins/" % OPT
add_plugin_data = {
        "name":"oauth2",
        "config":{
            "scopes":"guest,email,phone,todos",
            "mandatory_scope":"true",
            "enable_password_grant":"true",
            "provision_key":OPT["PROVISION_KEY"]
            }
        }

request = requests.post(add_plugin_url, json=add_plugin_data)
print request.status_code
print request.text



print "\n\nADD CONSUMER #############################################################"
add_admin_url = "http://%(KONG_ADMIN_ADDR)s/apis/%(API_NAME)s/plugins/" % OPT
add_admin_data = {
        "username":OPT["ADMIN_ID"],
        "custom_id":OPT["ADMIN_ID"]
        }
print request.status_code
print request.text


print "\n\nPRINT EXISTING CREDENTIAL #############################################################"
get_credential_url = "http://%(KONG_ADMIN_ADDR)s/consumers/%(ADMIN_ID)s/oauth2" % OPT
response = requests.get(get_credential_url).json()
print response

print "\n\nDELETE ACCESS TOKEN FOR  CREDENTIAL #############################################################"
for r in response["data"]:
    if r["name"] == OPT["API_NAME"]:
        delete_url = ("http://%(KONG_ADMIN_ADDR)s/consumers/%(ADMIN_ID)s/oauth2/" + r["id"]) %OPT
        requests.delete(delete_url)


print "\n\nADD CREDENTIAL #############################################################"
add_cred_url = "http://%(KONG_ADMIN_ADDR)s/consumers/%(ADMIN_ID)s/oauth2" % OPT
add_cred_data = {
    "name":OPT["API_NAME"],
    "client_id":OPT["CLIENT_ID"],
    "client_secret":OPT["CLIENT_SECRET"],
    "redirect_uri":"http://some-domain/endpoint/"
}
request = requests.post(add_cred_url, json=add_cred_data)
print request.status_code
print request.text


print "\n\nPRINT NEW CREDENTIAL #############################################################"
response = requests.get(get_credential_url).json()
print response

print "\n\nADD TOKEN #############################################################"
for r in response["data"]:
    if r["name"] == OPT["API_NAME"]:
        add_token_url = "http://%(KONG_ADMIN_ADDR)s/oauth2_tokens" % OPT
        add_token_data = {
            "credential_id":r["id"],
            "token_type":"bearer",
            "access_token":OPT["ADMIN_ACCESS_TOKEN"],
            "refresh_token":OPT["ADMIN_REFRESH_TOKEN"],
            "expires_in":360000000
        }
        request = requests.post(add_token_url, json=add_token_data)
        print request.status_code
        print request.text 
